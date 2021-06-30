//
//  CurrencyConverterWorker.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

final class CurrencyConverterWorker {
    
    // MARK:  Properties
    
    private let apiClient: CurrencyLiveApiClient
    
    // MARK: Initializers
    
    init(apiClient: CurrencyLiveApiClient = CurrencyLiveApiClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: Class Funcitons
    
    func fetchGetCurrencies(source: String, _ completion: @escaping (Result<CurrencyResponse, ResponseError>) -> ()) {
        apiClient.fetchGetCurrencies(source: source, completion: completion)
    }
    
}
