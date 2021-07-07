//
//  DataManager.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

protocol DataManager {
    associatedtype T
    func request(_ request:CurrencyConverterRequests, completion: @escaping (T?,Error?) -> ())
}

enum CurrencyConverterRequests {
    case getExchangeRates
    case getSupportedCurrencies
}
