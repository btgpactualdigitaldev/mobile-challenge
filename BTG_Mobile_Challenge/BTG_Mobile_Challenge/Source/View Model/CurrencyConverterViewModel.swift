//
//  CurrencyConverterViewModel.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation

final class CurrencyConverterViewModel: CurrencyConverterViewModeling {
    
    typealias Currency = [String: Double]
    
    weak var delegate: CurrencyConverterViewModelDelegate?
                    
    var fromCurrencyValue: String? {
        didSet {
            toCurrencyValue = convert(amount: fromCurrencyValue ?? "")
        }
    }
    
    @StorageVariables(key: CurrencyValuesKeys.fromCurrencyCode.rawValue, defaultValue: "USD") 
    var fromCurrencyCode: String {
        didSet {
            fetchCurrencyLiveQuote()
        }
    }
    
    @StorageVariables(key: CurrencyValuesKeys.fromCurrencyName.rawValue, defaultValue: "United States Dollar") 
    var fromCurrencyName: String {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.updateUI()
            }
        }
    }

    var toCurrencyValue: String? = "0.00" {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.updateUI()
            }
        }
    }
    
    @StorageVariables(key: CurrencyValuesKeys.toCurrencyCode.rawValue, defaultValue: "BRL") 
    var toCurrencyCode: String {
        didSet {
            fetchCurrencyLiveQuote()
        }
    }
    
    @StorageVariables(key: CurrencyValuesKeys.toCurrencyName.rawValue, defaultValue: "Brazilian Real") 
    var toCurrencyName: String {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.updateUI()
            }
        }
    }
    
    private let requestManager: RequestManager
    private let coordinator: CurrencyConverterCoordinator
    
    private var currency: Currency = [:]
    private var listResponse: CurrencyResponseFromList?
    
    init(requestManager: RequestManager, coordinator: CurrencyConverterCoordinator) {
        self.requestManager = requestManager
        self.coordinator = coordinator
        fetchCurrencyListQuote()
    }
    
    func fetchCurrencyLiveQuote() {
        
        guard let url = CurrencyAPIEndpoint.live.url else {
            return
        }
        
        self.requestManager.getRequest(url: url, decodableType: CurrencyReponseFromLive.self) { [weak self] (response) in
            switch response {
            case .success(let result):
                let fetchedCurrency = result.quotes
                self?.currency = fetchedCurrency
            case .failure(let error):
                ErrorHandlerObject().genericErrorHandling(title: "Error Fetching Live Response", message: error.localizedDescription)
            }
        }
    }
    
    func fetchCurrencyListQuote() {
        guard let url = CurrencyAPIEndpoint.list.url else {
            return
        }
        
        self.requestManager.getRequest(url: url, decodableType: CurrencyResponseFromList.self) { [weak self] (response) in
            switch response {
            case .success(let result):
                self?.listResponse = result
            case .failure(let error):
                ErrorHandlerObject().genericErrorHandling(title: "Error fetching list response", message: error.localizedDescription)
            }
        }
    }
    
    
    func convert(amount: String) -> String {
        
        guard let doubleValue = Double(amount) else {
            return "0"
        }
        
        if fromCurrencyCode == "USD" {
            return convertFromUSD(amount: doubleValue)
        }
        
        if toCurrencyCode == "USD" {
            return convertToUSD(amount: doubleValue)
        }
        
        guard let currencyValueFromUSD = currency["USD" + toCurrencyCode] else {
            return ""
        }
        
        guard let currencyValueToUSD = currency["USD" + fromCurrencyCode] else {
            return ""
        }
        
        let convertedValue = (currencyValueToUSD/currencyValueFromUSD) * doubleValue
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyCode
        numberFormatter.numberStyle = .currencyISOCode
        
        return numberFormatter.string(from: NSNumber(value: convertedValue)) ?? ""
    }
    
    func convertFromUSD(amount: Double) -> String {
        guard let USDValue = currency["USD" + toCurrencyCode] else {
            return ""
        }
        
        let convertedValue = amount * USDValue
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyCode        
        numberFormatter.numberStyle = .currencyISOCode
        
        return numberFormatter.string(from: NSNumber(value: convertedValue)) ?? ""
    }
    
    func convertToUSD(amount: Double) -> String {
        guard let USDValue = currency["USD" + fromCurrencyCode] else {
            return ""
        }
        
        let currencyValue = 1/USDValue
        let convertedValue = amount * currencyValue
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "USD"
        numberFormatter.numberStyle = .currencyISOCode
        
        return numberFormatter.string(from: NSNumber(value: convertedValue)) ?? ""
    }
    
    func swapCurrencies() {
        let lastCurrencyCode = fromCurrencyCode
        let lastCurrencyName = fromCurrencyName
        
        fromCurrencyCode = toCurrencyCode
        toCurrencyCode = lastCurrencyCode
        
        fromCurrencyName = toCurrencyName
        toCurrencyName = lastCurrencyName
        
        toCurrencyValue = convert(amount: fromCurrencyValue ?? "")
    }
    
    func pickCurrencies(selectCase: SelectCase) {
        if let response = listResponse {
            coordinator.changeCurrency(selectedCase: selectCase, response: response)
        }
    }
}
