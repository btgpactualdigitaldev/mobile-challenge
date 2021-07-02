//
//  CurrencyLiveRateProviding.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol CurrencyLiveRateProviding: Providing {
    func getCurrencyLiveRate(_ completion: @escaping (Result<CurrencyLiveRate, Error>) -> Void)
}

extension CurrencyLiveRateProviding {
    func getCurrencyLiveRate(_ completion: @escaping (Result<CurrencyLiveRate, Error>) -> Void) {
        network.execute(Endpoint.currencyLiveRate, completion: completion)
    }
}
