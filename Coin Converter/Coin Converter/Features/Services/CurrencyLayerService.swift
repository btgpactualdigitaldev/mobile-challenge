//
//  CurrencyLayerService.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

/// protocol responsible for implementing calls from the Currency Layer
protocol CurrencyLayerServiceProtocol {
    
    /// request the currencies
    func requestCurrencies(completion: @escaping ([CurrencyModel]?, Error?) -> Void)
    
    /// request the quotes
    func requestQuotes(completion: @escaping ([QuoteModel]?, Error?) -> Void)
}

class CurrencyLayerService: CurrencyLayerServiceProtocol {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let networkService: NetworkService
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(withSession session: URLSessionProtocol = URLSession.shared) {
         networkService = NetworkService(withSession: session)
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func requestCurrencies(completion: @escaping ([CurrencyModel]?, Error?) -> Void) {
        let fileStorareType: FileStorareType = .list
        
        if Reachability.isConnectedToNetwork() {
            let endPoint: Endpoint.CurrencyLayer = Endpoint.CurrencyLayer.list
            networkService.request(model: CurrenciesContainerModel.self, endpoint: endPoint) { result in
                switch result {
                case .success(let container):
                    if container.success {
                        StorageManager.shared.store(container.currencies, fileStorareType: fileStorareType)
                        completion(container.currencies, nil)
                    } else {
                        
                        if let errorModel: ErrorModel = container.error {
                            //TODO: Implement register log
                            print(errorModel.info)
                        }
                        
                        let error: Error = NSError(domain: #file, code: -1, userInfo: [NSLocalizedDescriptionKey: "The data could not be read."])
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else if StorageManager.shared.fileExists(fileStorareType) {
            let currencies: [CurrencyModel] = StorageManager.shared.retrieve(fileStorareType, as: [CurrencyModel].self)
            completion(currencies, nil)
        } else {
            let error: Error = NSError(domain: #file, code: -1, userInfo: [NSLocalizedDescriptionKey: "Check your internet connection."])
            completion(nil, error)
        }
    }
    
    func requestQuotes(completion: @escaping ([QuoteModel]?, Error?) -> Void) {
        let fileStorareType: FileStorareType = .live
        
        if Reachability.isConnectedToNetwork() {
            let endPoint: Endpoint.CurrencyLayer = Endpoint.CurrencyLayer.live
            networkService.request(model: QuotesContainerModel.self, endpoint: endPoint) { result in
                switch result {
                case .success(let container):
                    if container.success {
                        StorageManager.shared.store(container.quotes, fileStorareType: fileStorareType)
                        completion(container.quotes, nil)
                    } else {
                        if let errorModel: ErrorModel = container.error {
                            //TODO: Implement register log
                            print(errorModel.info)
                        }
                        
                        let error: Error = NSError(domain: #file, code: -1, userInfo:  [NSLocalizedDescriptionKey: "The data could not be read."])
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else if StorageManager.shared.fileExists(fileStorareType) {
            let quotes: [QuoteModel] = StorageManager.shared.retrieve(fileStorareType, as: [QuoteModel].self)
            completion(quotes, nil)
        } else {
            let error: Error = NSError(domain: #file, code: -1, userInfo: [NSLocalizedDescriptionKey: "Check your internet connection."])
            completion(nil, error)
        }
    }
    
}
