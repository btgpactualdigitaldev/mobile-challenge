//
//  CurrencyClient.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation


struct CurrencyClient: APIClient {    
    
    
    var session: URLSessionProtocol
    typealias ListFetchCompletion = (Result<CurrencyList, APIError>) -> Void
    typealias LiveFetchByNamesCompletion = (Result<CurrencyLive, APIError>) -> Void
    
    init(session: URLSessionProtocol = URLSession.shared){
        self.session = session
    }
    
    
    func getListOfCurrencies(completion: @escaping ListFetchCompletion){
        
        guard let request = CurrencyProvider.list.request else {
            return completion(.failure(.badRequest))
        }
        
        
        fetch(withRequest: request, withDecondingType: CurrencyList.self) { (result) in
            
            switch result {
                
            case .success(let currencyList):
                completion(.success(currencyList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLiveCurrenciesByNames(origin: String, destination: String, completion: @escaping LiveFetchByNamesCompletion){
        
        guard let request = CurrencyProvider.liveByNames(origin: origin, destination: destination).request else {
            return completion(.failure(.badRequest))
        }
        
        fetch(withRequest: request, withDecondingType: CurrencyLive.self) { (result) in
            switch result {
            
            case .success(let currencyLive):
                completion(.success(currencyLive))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getLiveCurrencies(completion: @escaping LiveFetchByNamesCompletion){
        
        guard let request = CurrencyProvider.live.request else {
            return completion(.failure(.badRequest))
        }
        
        fetch(withRequest: request, withDecondingType: CurrencyLive.self) { (result) in
            switch result {
            
            case .success(let currencyLive):
                completion(.success(currencyLive))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
}
