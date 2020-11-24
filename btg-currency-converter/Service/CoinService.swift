//
//  CoinService.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 24/11/20.
//


import Foundation
enum HttpError: String, Error {
    case invalidAccess
    case unableToComplete
    case invalidResponse
    case invallidData
}


class CoinService {
    
    static let shared = CoinService()
    var coin: String?
    
    func getCoins(completed: @escaping(Result<CoinEntity, HttpError>) -> Void) {
        guard let url = URL(string: Constant.baseUrl + "list?access_key=" + Constant.key) else {
            completed(.failure(.invalidAccess))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invallidData))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invallidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let objct = try decoder.decode(CoinEntity.self, from: data)
                completed(.success(objct))
            } catch {
                completed(.failure(.invallidData))
            }
        }
        task.resume()
    }
    
    func getRate(completed: @escaping (Result<RateEntity, HttpError>) ->()) {
        guard let url = URL(string: Constant.baseUrl +  "live?access_key=" + Constant.key + "&currencies=" + coin! ) else {
            completed(.failure(.invalidAccess))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invallidData))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invallidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let objct = try decoder.decode(RateEntity.self, from: data)
                completed(.success(objct))
            } catch {
                completed(.failure(.invallidData))
            }
        }
        
        task.resume()
    }
}
