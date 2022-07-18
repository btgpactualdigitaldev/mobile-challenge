//
//  CurrenciesService.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 17/07/22.
//

import Foundation

protocol CurrenciesServiceProtocol {
    typealias CurrenciesResult = Result<Currencies, ServiceError>
    func fetchCurrencyList(completion: @escaping (CurrenciesResult) -> Void)
}

class CurrenciesServiceDefault: CurrenciesServiceProtocol {
    
    private var networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()
    
    private func dispatchCompletion(completion: @escaping (CurrenciesResult) -> Void, result: CurrenciesResult) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    func fetchCurrencyList(completion: @escaping (CurrenciesResult) -> Void) {
        networkDispatcher.request(endpoint: .list) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try JSONDecoder().decode(Currencies.self, from: data)
                    self.dispatchCompletion(completion: completion, result: .success(list))
                } catch {
                    self.dispatchCompletion(completion: completion, result: .failure(.parseError))
                }
            
            case .failure(let err):
                self.dispatchCompletion(completion: completion, result: .failure(ServiceError.networkError(err.localizedDescription)))
            }
        }
    }
}
