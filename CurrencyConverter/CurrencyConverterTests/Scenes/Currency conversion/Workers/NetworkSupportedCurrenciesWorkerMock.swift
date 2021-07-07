//
//  NetworkSupportedCurrenciesWorkerMock.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import Foundation

struct NetworkSupportedCurrenciesWorkerMock: SupportedCurrenciesWorkerProtocol {
    var returnError: Error? = nil
    
    func loadSupportedCurrencies(completion: @escaping (SupportedCurrencies?, Error?) -> ()) {
        if returnError == nil {
            completion(Seeds.APISeeds.supportedCurrencies,nil)
        } else {
            completion(nil,returnError)
        }
    }
}
