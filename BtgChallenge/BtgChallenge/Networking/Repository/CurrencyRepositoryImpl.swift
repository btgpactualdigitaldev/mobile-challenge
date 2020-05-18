//
//  CurrencyRepositoryImpl.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

final class CurrencyRepositoryImpl: CurrencyRepository {
    
    let provider: HTTPProvider<CurrencyRouter>
    let localStorage: LocalStorage
    
    init(provider: HTTPProvider<CurrencyRouter>, localStorage: LocalStorage) {
        self.provider = provider
        self.localStorage = localStorage
    }
    
    func live(_ currencies: String,
              _ source: String,
              _ callback: @escaping (LiveResult) -> Void
    ) {
        
        provider.request(router: .live(currencies, source)) { [weak self] (result: LiveResult) in
            switch result {
            case .success(let liveResponse):
                self?.localStorage.setLiveCache(liveResponse: liveResponse)
                callback(result)
            case .failure(let error):
                if let liveCached: LiveResponse = self?.localStorage.getCachedObject() {
                    callback(.success(liveCached))
                } else {
                    callback(.failure(error))
                }
            }
        }
    }
    
    func convert(_ fromCoin: String,
                 _ toCoin: String,
                 _ amount: String,
                 _ callback: @escaping (ConvertResult) -> Void
    ) {
        provider.request(router: .convert(fromCoin, toCoin, amount)) { result in
            callback(result)
        }
    }
    
    func list(_ callback: @escaping (ListResult) -> Void) {
        provider.request(router: .list) { [weak self] (result: ListResult) in
            switch result {
            case .success(let listResponse):
                self?.localStorage.setListCache(listResponse: listResponse)
                callback(result)
            case .failure(let error):
                if let listCached: ListResponse = self?.localStorage.getCachedObject() {
                    callback(.success(listCached))
                } else {
                    callback(.failure(error))
                }
            }
        }
    }
    
}
