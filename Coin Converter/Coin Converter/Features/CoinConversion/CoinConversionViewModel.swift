//
//  CoinConversionViewModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

class CoinConversionViewModel {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let currencyLayerService: CurrencyLayerServiceProtocol
    private var currencies: [CurrencyModel]?
    private let sourceSymbol: String = "USD"
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var selectedOriginCurrency: CurrencyModel?
    var selectedDestinyCurrency: CurrencyModel?
    var priceDate: String = ""
    var onePrice: Double = 0
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(currencyLayerService: CurrencyLayerServiceProtocol) {
        self.currencyLayerService = currencyLayerService
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension CoinConversionViewModel {
    
    func requestCurrencies(completion: ((Error?) -> Void)?) {
        currencyLayerService.requestCurrencies { [weak self] (currencies, error) in
            guard let self: CoinConversionViewModel = self else { return }
            
            if let error: Error = error {
                completion?(error)
                return
            }
            
            self.currencies = currencies
            
            let locale = Locale.current
            if let currencyCode: String = locale.currencyCode {
                self.selectedOriginCurrency = currencies?.filter{ $0.symbol.uppercased() == currencyCode }.first
            } else {
                self.selectedOriginCurrency = currencies?.first
            }
            self.selectedDestinyCurrency = currencies?.filter{ $0.symbol.uppercased() == self.sourceSymbol }.first
            
            completion?(nil)
        }
    }
    
    func convertCurrency(value: String, completion: ((Double?, Error?) -> Void)?) {
        let valueDigits: String = value.digits
        
        guard var convetedValue: Double = Double(valueDigits) else {
            let error: Error = NSError(domain: #file, code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid value"])
            completion?(nil, error)
            return
        }
        
        convetedValue /= 100
        
        self.priceDate = ""
        self.onePrice = 0
        
        currencyLayerService.requestQuotes { [weak self] (quotes, error) in
            guard let self: CoinConversionViewModel = self else { return }
            
            if let error: Error = error {
                completion?(nil, error)
                return
            }
            
            guard let originSymbol: String = self.selectedOriginCurrency?.symbol,
                let destinySymbol: String = self.selectedDestinyCurrency?.symbol else {
                    let error: Error = NSError(domain: #file, code: -1, userInfo: [NSLocalizedDescriptionKey: "Select the currency of origin and destination"])
                    completion?(nil, error)
                    return
            }
            
            if originSymbol != self.sourceSymbol,
                let quote: QuoteModel = quotes?.filter({ $0.symbol.uppercased() == originSymbol }).first {
                self.priceDate = quote.updateDate.dateFormatted
                convetedValue = convetedValue / quote.price
                self.onePrice = 1 / quote.price
            }
            
            if destinySymbol != self.sourceSymbol {
                if let quote: QuoteModel = quotes?.filter({ $0.symbol.uppercased() == destinySymbol }).first {
                    self.priceDate = quote.updateDate.dateFormatted
                    convetedValue = convetedValue * quote.price
                    self.onePrice = self.onePrice * quote.price
                } else {
                    let error: Error = NSError(domain: #file, code: -1, userInfo: [NSLocalizedDescriptionKey: "There was a problem converting"])
                    completion?(nil, error)
                    return
                }
            }
            
            completion?(convetedValue, nil)
        }
    }
    
    func invertCurrency() {
        let auxCurrency: CurrencyModel? = selectedOriginCurrency
        selectedOriginCurrency = selectedDestinyCurrency
        selectedDestinyCurrency = auxCurrency
    }
    
    func validate(text: String?) -> String? {
        var messageError: String?
        
        if text == nil || text?.isEmpty == true {
            messageError = "- Inform the value\n"
        }
        
        if selectedOriginCurrency == nil {
            messageError = "- Select origin currency\n"
        }
        
        if selectedDestinyCurrency == nil {
            messageError = "- Select destiny currency\n"
        }
        
        return messageError
    }
    
    func currencyListViewModel(currencyType: CurrencyType) -> CurrencyListViewModel? {
        guard let currencies: [CurrencyModel] = currencies else { return nil }
        
        let selectedCurrency: CurrencyModel?
        switch currencyType {
        case .origin:
            selectedCurrency = selectedOriginCurrency
        case .destiny:
            selectedCurrency = selectedDestinyCurrency
        }
        
        return CurrencyListViewModel(currencies: currencies, selectedCurrency: selectedCurrency)
    }
    
    func updateCurrency(currencyType: CurrencyType, currencyModel: CurrencyModel, completion: (() -> Void)) {
        switch currencyType {
        case .origin:
            selectedOriginCurrency = currencyModel
        case .destiny:
            selectedDestinyCurrency = currencyModel
        }
        
        completion()
    }
}
