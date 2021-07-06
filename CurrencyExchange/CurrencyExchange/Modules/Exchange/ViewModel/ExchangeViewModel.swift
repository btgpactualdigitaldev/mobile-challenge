//
//  ExchangeViewModel.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

protocol ExchangeViewModelDelegate: class {
    func willBeginCurrencyExchange()
    func didFinishCurrencyExchange(message: String?, convertedValue: Double?)
    func handleConverterError(message: String)
}

final class ExchangeViewModel {
    
    weak var delegate: ExchangeViewModelDelegate?
    var originCurrency: Currency?
    var destinationCurrency: Currency?
    
    func executeConverterWithExchangeValue(_ value: String?){
        do {
            try self.converter(exchangeValue: value)
        } catch ExchangeError.exchangeValueCannotBeUnwrapped{
            self.delegate?.handleConverterError(message: ExchangeError.exchangeValueCannotBeUnwrapped.description)
        }catch ExchangeError.currencyCannotBeUnwrapped{
            self.delegate?.handleConverterError(message: ExchangeError.currencyCannotBeUnwrapped.description)
        }catch ExchangeError.currenciesAreEqual{
            self.delegate?.handleConverterError(message: ExchangeError.currenciesAreEqual.description)
        }catch {
            self.delegate?.handleConverterError(message: ExchangeError.unknown.description)
        }
    }
        
    func converter(exchangeValue: String?) throws {
        
        self.delegate?.willBeginCurrencyExchange()
        
        let value = try unwrappExchangeValue(exchangeValue: exchangeValue)
        let originCurrency = try unwrappWithCurrency(self.originCurrency)
        let destinationCurrency = try unwrappWithCurrency(self.destinationCurrency)
        try verifyCurrenciesAreEqual(withOriginCurrency: originCurrency, andWithDestinationCurrency: destinationCurrency)
        
        
        if NetworkMonitor.shared.isConnected {
            converterWhenNetworkIsAvailable(originCurrency: originCurrency, destinationCurrency: destinationCurrency, value: value)
        }else {
            self.converterWhenNetworkIsNotAvailableWithValue(value, withOriginCurrency: originCurrency, withDestinationCurrency: destinationCurrency)
        }
        
    }
    
    private func converterWhenNetworkIsNotAvailableWithValue(_ value: Double, withOriginCurrency origin: Currency, withDestinationCurrency destination: Currency){
        
        var convertedValue =  destination.value / origin.value
        convertedValue = value * convertedValue
        self.delegate?.didFinishCurrencyExchange(message: nil, convertedValue: convertedValue)
    }
    
    private func converterWhenNetworkIsAvailable(originCurrency: Currency, destinationCurrency: Currency, value: Double){
        let currencyClient = CurrencyClient(session: URLSession.shared)
        currencyClient.getLiveCurrenciesByNames(origin: originCurrency.code, destination: destinationCurrency.code) { (result) in
            
            switch result {
            
            case .success(let currencies):
                
                guard let originValue = currencies.quotes?["USD"+originCurrency.code], let destinationValue = currencies.quotes?["USD"+destinationCurrency.code] else {
                    return
                }
                
                
                var convertedValue =  destinationValue / originValue
                convertedValue = value * convertedValue
                
                self.delegate?.didFinishCurrencyExchange(message: nil, convertedValue: convertedValue)
            case .failure(let error):
                self.delegate?.didFinishCurrencyExchange(message: error.description, convertedValue: nil)
            }
        }
    }
    
    private func unwrappExchangeValue(exchangeValue: String?) throws -> Double{
        
        guard let exchangeValueUnwrapped = exchangeValue, !exchangeValueUnwrapped.isEmpty, let value = Double(exchangeValueUnwrapped) else {
            throw ExchangeError.exchangeValueCannotBeUnwrapped
        }
        
        return value
    }
    
    private func unwrappWithCurrency(_ currency: Currency?) throws -> Currency {
        guard let currency = currency else {
            throw ExchangeError.currencyCannotBeUnwrapped
        }
        
        return currency
    }
    
    private func verifyCurrenciesAreEqual(withOriginCurrency origin: Currency, andWithDestinationCurrency destination: Currency) throws {
        if origin.code == destination.code {
            throw ExchangeError.currenciesAreEqual
        }
    }

}
