//
//  APICurrency.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

import Foundation

protocol APICurrencyProtocol {
    func getCurrency(completion: @escaping(Result<[CurrencyEntity], RepositoryError>) -> Void)
}

struct APICurrency: APICurrencyProtocol {
    typealias ListResult = Result<CurrencyListResponse, RepositoryError>
    typealias LiveResult = Result<CurrencyLiveResponse, RepositoryError>
    
    func getCurrency(completion: @escaping (Result<[CurrencyEntity], RepositoryError>) -> Void) {
        let group = DispatchGroup()
        var error: RepositoryError?
        var currencyList: CurrencyListResponse?
        var currencyLive: CurrencyLiveResponse?
        
        group.enter()
        API().fetch(endpoint: Endpoint.list.url) { (result: ListResult) in
            switch result {
            case let .success(entities):
                currencyList = entities
            case let .failure(err):
                error = err
            }
            group.leave()
        }
        
        group.enter()
        API().fetch(endpoint: Endpoint.live.url) { (result: LiveResult) in
            switch result {
            case let .success(entities):
                currencyLive = entities
            case let .failure(err):
                error = err
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.global()) {
            if let error = error {
                completion(.failure(error))
            } else {
                let data = parseResponseToEntity(list: currencyList,
                                                 live: currencyLive)
                completion(.success(data))
            }
        }
    }
    
    func parseResponseToEntity(list: CurrencyListResponse?,
                               live: CurrencyLiveResponse?) -> [CurrencyEntity] {
        guard let list = list,
              let live = live else { return [] }
        return list.currencies.map {
            let key = "USD\($0.key)"
            let value = live.quotes[key]
            return CurrencyEntity(code: $0.key,
                                  name: $0.value,
                                  value: value ?? 0.0)
        }
    }
}
