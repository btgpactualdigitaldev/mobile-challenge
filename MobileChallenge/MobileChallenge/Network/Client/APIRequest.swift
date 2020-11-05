//
//  APIRequest.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

class APIRequest {
    var baseUrl = "http://api.currencylayer.com/"
    var accessKey = "ec78bc51f4e42cc43f6046d23eb8a8b9"
    
    func fetchAllCurrencies(completionHandler: @escaping (Result<[String: String]?, APIError>) -> Void) {
        let url = URL(string: baseUrl + "list?access_key=" + accessKey)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let _ = error {
                completionHandler(.failure(.urlError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.responseError))
                return
            }
            
            guard let data = data else{
                completionHandler(.failure(.dataError))
                return
            }
            
            guard let currencySumary = try? JSONDecoder().decode(CurrencyName.self, from: data) else{
                completionHandler(.failure(.decodeError))
                return
            }
            
            completionHandler(.success(currencySumary.currencies))
        })
        task.resume()
    }
    
    func fetchAllExchanges(completionHandler: @escaping (Result<[String: Double]?, APIError>) -> Void) {
        let url = URL(string: baseUrl + "live?access_key=" + accessKey)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let _ = error {
                completionHandler(.failure(.urlError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.responseError))
                return
            }
            
            guard let data = data else{
                completionHandler(.failure(.dataError))
                return
            }
            
            guard let currencySumary = try? JSONDecoder().decode(CurrencyExchange.self, from: data) else{
                completionHandler(.failure(.decodeError))
                return
            }
            
            completionHandler(.success(currencySumary.quotes))
        })
        task.resume()
    }
    
    func fetchSpecificExchanges(currencyCodes: [String], completionHandler: @escaping (Result<[String: Double]?, APIError>) -> Void) {
        let url = URL(string: baseUrl + "live?access_key=" + accessKey + "&currencies=" + currencyCodes.joined(separator:","))!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let _ = error {
                completionHandler(.failure(.urlError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.responseError))
                return
            }
            
            guard let data = data else{
                completionHandler(.failure(.dataError))
                return
            }
            
            guard let currencySumary = try? JSONDecoder().decode(CurrencyExchange.self, from: data) else{
                completionHandler(.failure(.decodeError))
                return
            }
            
            completionHandler(.success(currencySumary.quotes))
        })
        task.resume()
    }
}
