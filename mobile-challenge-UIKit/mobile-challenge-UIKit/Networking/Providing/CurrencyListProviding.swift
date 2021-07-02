//
//  CurrencyListProviding.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol CurrencyListProviding: Providing {
    func getCurrencyList(_ completion: @escaping (Result<CurrencyList, Error>) -> Void)
}

extension CurrencyListProviding {
    func getCurrencyList(_ completion: @escaping (Result<CurrencyList, Error>) -> Void) {
        network.execute(Endpoint.currencyList, completion: completion)
    }
}
