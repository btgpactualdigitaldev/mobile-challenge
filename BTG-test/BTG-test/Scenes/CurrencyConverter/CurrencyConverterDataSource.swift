//
//  CurrencyConverterDataSource.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import Foundation
import Moya

protocol CurrencyConverterDataSourceDelegate: class {
    func successConvertCurrency(result: Double)
    func failureConvertCurrency(error: String)
}

protocol CurrencyConverterDataSourceProtocol {
    var delegate: CurrencyConverterDataSourceDelegate? { get set }
    func convertCurrency(from: String, to: String, amount: Double)
    func getCurrencyList(completion: @escaping (_ list: [Currency]?, _ error: String?) -> Void)
}

class CurrencyConverterDataSource: CurrencyConverterDataSourceProtocol {
    
    weak var delegate: CurrencyConverterDataSourceDelegate?
    
    private let apiManager = MoyaProvider<CurrencyLayerApi>()
    
    func convertCurrency(from: String, to: String, amount: Double) {
        let currencies = "USD,\(from),\(to)"
        let rate = CurrencyLayerApi.getRate(currencies: currencies)
        apiManager.request(rate) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                let converted = try? JSONDecoder().decode(CurrencyLayerConvertResponse.self, from: value.data)
                guard
                    let success = converted?.success,
                    success,
                    let fromRate = converted?.quotes?["USD\(from)"],
                    let toRate = converted?.quotes?["USD\(to)"]
                    else {
                        self.delegate?.failureConvertCurrency(error: "Ocorreu um erro inesperado!")
                        return
                }
                let result = self.calculate(fromValue: fromRate, toValue: toRate, amount: amount)
                self.delegate?.successConvertCurrency(result: result)
            case .failure:
                self.delegate?.failureConvertCurrency(error: "Ocorreu um erro inesperado!")
            }
        }
    }
    
    private func calculate(fromValue: Double, toValue: Double, amount: Double) -> Double {
        let fromToDolar = (amount / fromValue)
        let result = fromToDolar * toValue
        return result
    }
    
    func getCurrencyList(completion: @escaping (_ list: [Currency]?, _ error: String?) -> Void) {
        apiManager.request(.list) { (response) in
            switch response {
            case .success(let value):
                let resp = try? JSONDecoder().decode(CurrencyLayerListResponse.self, from: value.data)
                guard let currenciesDict = resp?.currencies else {
                    completion(nil, "Ocorreu um erro inesperado!")
                    return
                }
                var currencies: [Currency] = []
                currenciesDict.forEach { (currencyDict) in
                    let title = currencyDict.key
                    let decription = currencyDict.value
                    let currency = Currency(title: title, description: decription)
                    currencies.append(currency)
                }
                currencies.sort { (curr1, curr2) -> Bool in
                    curr1.title < curr2.title
                }
                completion(currencies, nil)
            case.failure:
                completion(nil, "Ocorreu um erro inesperado!")
            }
        }
    }
}
