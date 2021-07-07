//
//  NetworkExchangeRatesWorker.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

final class NetworkExchangeRatesWorker<DM: DataManager, SM: StorageManager>: ExchangeRatesWorkerProtocol where DM.T == Data, SM.DataType == ExchangeRates {
    var dataManager: DM
    var storageManager: SM
    
    init(dataManager: DM, storageManager: SM) {
        self.dataManager = dataManager
        self.storageManager = storageManager
    }
    
    func getExchangeRates(completion: @escaping (ExchangeRates?, Error?) -> ()) {
        dataManager.request(.getExchangeRates) { (data, error) in
            if error == nil,
                let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(ExchangeRates.self, from: data)
                    self.saveExchangeRates(exchangeRates: decodedData)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, NetworkExchangeRatesWorkerError.cannotDecodeData)
                }
            } else {
                let savedExchangeRates = self.getExchangeRatesFromStorage()
                if savedExchangeRates.quotes.count > 0 {
                    completion(savedExchangeRates, nil)
                } else {
                    completion(nil, NetworkSupportedCurrenciesWorkerError.requestError)
                }
            }
        }
    }
    
    private func getExchangeRatesFromStorage() -> ExchangeRates {
        return storageManager.get()
    }
    
    private func saveExchangeRates(exchangeRates: ExchangeRates) {
        storageManager.save(exchangeRates)
    }
}

enum NetworkExchangeRatesWorkerError: Error {
    case cannotDecodeData
    case requestError
}
