//
//  CurrencyRepository.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

import Foundation

class CurrencyRepository: CurrencyRepositoryProtocol {

    // MARK: - Attributes
    var network: Networking

    // MARK: - Initializer
    init(network: Networking) {
        self.network = network
    }

    // MARK: - Methods
    func getCurrencyList(completion: @escaping(Result<CurrencyObject, Error>) -> Void) {
        if Reachability.isConnectedToNetwork() {
            self.network.execute(requestProvider: Endpoint.currencies, completion: completion)
        } else {
            if let object = UserDefaults.standard.object(forKey: "\(CurrencyObject.self)") as? Data, let currencyObject = try? JSONDecoder().decode(CurrencyObject.self, from: object) {
                completion(.success(currencyObject))
            } else {
                completion(.failure(StringsDictionary.checkInternetConnection))
            }
        }
    }

    func getCurrenciesRate(completion: @escaping(Result<CurrencyRateObject, Error>) -> Void) {
        if Reachability.isConnectedToNetwork() {
            self.network.execute(requestProvider: Endpoint.currencyRate, completion: completion)
        } else {
            if let object = UserDefaults.standard.object(forKey: "\(CurrencyRateObject.self)") as? Data, let currencyRateObject = try? JSONDecoder().decode(CurrencyRateObject.self, from: object) {
                completion(.success(currencyRateObject))
            } else {
                completion(.failure(StringsDictionary.checkInternetConnection))
            }
        }
    }
}
