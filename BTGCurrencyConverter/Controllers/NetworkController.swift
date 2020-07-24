//
//  NetworkController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

class NetworkController {
    static let shared = NetworkController()
    private let accessKey = "d723abc7df7149aac552c7dccaab6337"
    
    private init() {}
    
    func getCurrencies(completed: @escaping(Result<SupportedCurrencies, BTGNetworkError>) ->Void) {
        let endpoint = UrlStubs.base.rawValue + UrlStubs.list.rawValue + accessKey
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
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
                let currencies = try decoder.decode(SupportedCurrencies.self, from: data)
                completed(.success(currencies))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getLiveConversion(completed: @escaping(Result<LiveQuotes, BTGNetworkError>) -> Void) {
        let endpoint = UrlStubs.base.rawValue + UrlStubs.live.rawValue + accessKey
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
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
                let currencies = try decoder.decode(LiveQuotes.self, from: data)
                completed(.success(currencies))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
