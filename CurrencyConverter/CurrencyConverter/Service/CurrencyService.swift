//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 06/10/20.
//

import Foundation

class CurrencyService {
    
    static let shared = CurrencyService()
    static private let accessKey = "585547f2d57e1e3316863590dbe63cd2"

    private let baseURL = "http://apilayer.net/api/"
    
    func getList(completed: @escaping (Result<ExchangeRateListResponseModel, CoinError>) -> Void) {
        let path = "list?access_key="
        
        let endpoint = baseURL + path + CurrencyService.accessKey
        
        guard let url = URL(string: endpoint) else {
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
                let objct = try decoder.decode(ExchangeRateListResponseModel.self, from: data)
                completed(.success(objct))
            } catch {
                completed(.failure(.invallidData))
            }
            
        }
        
        task.resume()
    }
    
    func getQuote(completed: @escaping (Result<CurrentQuoteResponseModel, CoinError>) ->()) {
        
        let path = "live?access_key="
        
        let endPoint = baseURL + path + CurrencyService.accessKey
        
        guard let url = URL(string: endPoint) else {
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
                let objct = try decoder.decode(CurrentQuoteResponseModel.self, from: data)
                completed(.success(objct))
            } catch {
                completed(.failure(.invallidData))
            }
            
        }
        
        task.resume()
    }
}
