//
//  CurrencyListWorker.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

final class CurrencyListWorker {
    
    // MARK:  Properties
    
    private let apiClient: CurrencyLiveApiClient
    
    // MARK: Initializers
    
    init(apiClient: CurrencyLiveApiClient = CurrencyLiveApiClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: Class Funcitons
    
    func fetchListCurrencies(_ completion: @escaping (Result<CurrencyListResponse, ResponseError>) -> ()) {
        apiClient.fetchListCurrencies(completion: completion)
    }
    
}
