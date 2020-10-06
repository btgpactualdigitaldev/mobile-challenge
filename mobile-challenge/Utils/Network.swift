//
//  Network.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Result<T> {
    case success(T)
    case error(ErrorNetwork)
}

class Network {
    
    func request<T: Codable>(url: String, method: HttpMethod, callback: @escaping (Result<T>) -> Void) {
        
        guard let url = URL(string: url) else {
            callback(.error(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                callback(.error(.connectionError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                callback(.success(result))
            } catch {
                
                callback(.error(.decodingError))
            }
            
        }.resume()
    }
}
