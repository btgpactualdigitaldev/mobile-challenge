//
//  CurrencyRepositoryMock.swift
//  XCurrencyTests
//
//  Created by Vinicius Nadin on 01/04/21.
//

import XCTest
@testable import XCurrency

class CurrencyRepositoryMock: CurrencyRepositoryProtocol {

    // MARK: - Attributes
    var network: Networking
    var getCurrenciesRateCount: Int = 0
    var getCurrencyListCount: Int = 0

    // MARK: - Initializer
    init(network: Networking) {
        self.network = network
    }

    // MARK: - Public Methods
    func getCurrenciesRate(completion: @escaping (Result<CurrencyRateObject, Error>) -> Void) {
        self.getCurrenciesRateCount += 1
        self.network.execute(requestProvider: Endpoint.currencies, completion: completion)
    }

    func getCurrencyList(completion: @escaping (Result<CurrencyObject, Error>) -> Void) {
        self.getCurrencyListCount += 1
        self.network.execute(requestProvider: Endpoint.currencyRate, completion: completion)
    }
}
