//
//  NetworkExchangeRatesWorkerMock.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import Foundation

struct NetworkExchangeRatesWorkerMock: ExchangeRatesWorkerProtocol {
    var returnError: Error? = nil
    
    func getExchangeRates(completion: @escaping (ExchangeRates?, Error?) -> ()) {
        if returnError == nil {
            completion(Seeds.APISeeds.exchangeRates,nil)
        } else {
            completion(nil,returnError)
        }
    }
}
