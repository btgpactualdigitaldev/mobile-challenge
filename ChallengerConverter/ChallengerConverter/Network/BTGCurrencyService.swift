//
//  BTGCurrencyService.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation

enum APIError: Error{
    case error(String)
}


class BTGCurrencyService {
    
    static func request<T: Codable>(provider: Provider, completion: @escaping (Result<T, Error>)-> Void) {
        
        let task = URLSession.shared.dataTask(with: request(provider: provider)){
            data, _, error in
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.error(error!.localizedDescription)))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch(let error) {
                    completion(.failure(APIError.error(error.localizedDescription)))
                }
            }
        }
        task.resume()
    }
    
    static private func request(provider: Provider)-> URLRequest {
        
        let url = URL(string: provider.endpoint)
        var request = URLRequest(url: url!)
        request.httpMethod = provider.method.rawValue
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]

        return request
    }
}
