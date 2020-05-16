//
//  BTGNetworkController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

struct BTGNetworkController {
    
    static let shared = BTGNetworkController()
    
    private let baseUrl = "http://api.currencylayer.com/"
    private let accessKey = ""
    private let accessKeyQueryParam = "access_key"
    private let livePath = "live"
    private let listPath = "list"
    
    //let cache = NSCache<NSString, UIImage>()
    #warning("add cache later")
    #warning("colocar tudo em portugues para o cliente")
    #warning("passar para constantes as coisas acima")
    
    private init(){}
    
    func getLiveCurrencies(completed: @escaping (Result<LiveQuoteRates, BTGNetworkErrorConstants>) -> Void ) {
        let endpoint = "\(baseUrl)\(livePath)?\(accessKeyQueryParam)=\(accessKey)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let quotes = try decoder.decode(LiveQuoteRates.self, from: data)
                if quotes.success {
                    completed(.success(quotes))
                } else {
                    completed(.failure(.montlhyAttemptsOver))
                }
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func getAvaliableCurrencies(completed: @escaping (Result<AvaliableCurrencies, BTGNetworkErrorConstants>) -> Void ) {
        let endpoint = "\(baseUrl)\(listPath)?\(accessKeyQueryParam)=\(accessKey)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let avaliableCurrencies = try decoder.decode(AvaliableCurrencies.self, from: data)
                if avaliableCurrencies.success {
                    completed(.success(avaliableCurrencies))
                } else {
                    completed(.failure(.montlhyAttemptsOver))
                }
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
