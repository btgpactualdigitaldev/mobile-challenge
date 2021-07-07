//
//  NetworkSupportedCurrenciesWorker.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

final class NetworkSupportedCurrenciesWorker<DM: DataManager, SM: StorageManager>: SupportedCurrenciesWorkerProtocol where DM.T == Data, SM.DataType == SupportedCurrencies {
    var dataManager: DM
    var storageManager: SM
    
    init(dataManager: DM, storageManager: SM) {
        self.dataManager = dataManager
        self.storageManager = storageManager
    }
    
    func loadSupportedCurrencies(completion: @escaping (SupportedCurrencies?, Error?) -> ()) {
        dataManager.request(.getSupportedCurrencies) { (data, error) in
            if error == nil,
                let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(SupportedCurrencies.self, from: data)
                    self.saveCurrencies(supportedCurrencies: decodedData)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, NetworkSupportedCurrenciesWorkerError.cannotDecodeData)
                }
            } else {
                let savedCurrencies = self.getCurrenciesFromStorage()
                if savedCurrencies.currencies.count > 0 {
                    completion(savedCurrencies, nil)
                } else {
                    completion(nil, NetworkSupportedCurrenciesWorkerError.requestError)
                }
            }
        }
    }
    
    private func getCurrenciesFromStorage() -> SupportedCurrencies {
        return storageManager.get()
    }
    
    private func saveCurrencies(supportedCurrencies: SupportedCurrencies) {
        storageManager.save(supportedCurrencies)
    }
}

enum NetworkSupportedCurrenciesWorkerError: Error {
    case cannotDecodeData
    case requestError
}
