//
//  NetworkManager.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

class NetworkManager {
    func request<T: Decodable>(service: NetworkServiceType, model: T.Type, completion: @escaping (Result<T,CurrencyError>) -> Void) {
        guard let url = URL(string: service.path) else {
            completion(.failure(.InvalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                if error.localizedDescription.lowercased().contains("offline") {
                    completion(.failure(.NoNetworkConnnectionError))
                } else {
                    completion(.failure(.UnknowError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.APIConnectionError))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let safeData = data, let object: T = self.decode(data: safeData) else {
                    completion(.failure(.DecodeError))
                    return
                }
                
                completion(.success(object))
            default:
                completion(.failure(.APIConnectionError))
            }
        }.resume()
    }
    
    private func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        
        guard let object = try? decoder.decode(T.self, from: data) else { return nil }
        
        return object
    }
}
