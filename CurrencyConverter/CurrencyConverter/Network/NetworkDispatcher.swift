//
//  NetworkDispatcher.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

protocol NetworkDispatcherProtocol {
    func request(endpoint: String, completion: @escaping (Result<Data, ServiceError>) -> Void)
}

class NetworkDispatcher: NetworkDispatcherProtocol {
    
    private let session = URLSession.shared
    
    func request(endpoint: String, completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        guard let url = URL(string: .baseUrl + endpoint) else {
            completion(.failure(.badURL))
            return
        }
        
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
