//
//  QuotationViewModel.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

class QuotationViewModel {
    
    var quotation: Quotation?
    var currency: Currency?
    var currenciesQuotation: [CurrencyQuotation] = []
    var manager: NetworkManager
    var group = DispatchGroup()
    var queue = DispatchQueue.global()
    
    init() {
        self.manager = NetworkManager()
    }
    
    func convert(value: Double, origin: Double, destiny: Double) -> String {
        let convertedValue = (value / origin) * destiny
        
        return String(format: "%.2f", convertedValue)
    }
}

extension QuotationViewModel {
    func getCurrenciesQuotation(completion: @escaping (Result<[CurrencyQuotation], CurrencyError>)-> Void) {
        
        var currencyError: CurrencyError?
        
        queue.async {
            self.fetchCurrencies { (error) in
                if let error = error {
                    currencyError = error
                }
                self.group.leave()
            }
            
            self.fetchQuotation { (error) in
                if let error = error {
                    currencyError = error
                }
                self.group.leave()
            }
            
            self.group.notify(queue: self.queue){
                if let error = currencyError {
                    completion(.failure(error))
                } else {
                    self.groupCurrencyQuotationInfo()
                    completion(.success(self.currenciesQuotation))
                }
            }
        }
    }
    
    func fetchQuotation(completion: @escaping (CurrencyError?)->()) {
        group.enter()
        manager.request(service: NetworkServiceType.live, model: Quotation.self) { (result) in
            switch result {
            case .success(let quotation):
                self.quotation = quotation
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func fetchCurrencies(completion: @escaping (CurrencyError?)->()) {
        group.enter()
        manager.request(service: .list, model: Currency.self) { (result) in
            switch result {
            case .success(let currency):
                self.currency = currency
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func groupCurrencyQuotationInfo() {
        self.currenciesQuotation = []
        guard let currencies = currency?.currencies else { return }
        guard let quotation = quotation?.quotes else { return }
        for (key, value) in currencies {
            let quoteKey = "USD\(key)"
            guard let quote = quotation[quoteKey] else { return }
            
            let currencyQuotation = CurrencyQuotation(code: key, currency: value, quotation: quote)
            self.currenciesQuotation.append(currencyQuotation)
        }
    }
}
