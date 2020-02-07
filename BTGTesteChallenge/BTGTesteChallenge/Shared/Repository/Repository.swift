//
//  Repository.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/4/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol BaseRepositoryProtocol {
    var baseURL: String { get set } //retrieve from plist
    var key: String { get set } //retrieve from plist
    var endpoint: Endpoint {get set}
}
extension BaseRepositoryProtocol {
    var url : URL {
        let urlString = "\(baseURL)\(endpoint.rawValue)\(key)"
        guard let url = URL(string: urlString) else {
            fatalError("Unable to get a url")
        }
        return url
    }
}

protocol LiveCurrencyRepositoryProtocol: class, BaseRepositoryProtocol {
    func fetchLiveCurrency(completionHandler: @escaping (Result<CurrencyRate>) -> ())
}

protocol ListCurrencyRepositoryProtocol: class, BaseRepositoryProtocol {
    func fetchListOfCurrency(completionHandler: @escaping (Result<CurrencyList>) -> ())
}

final class LiveCurrencyRepository: LiveCurrencyRepositoryProtocol {
    
    var baseURL: String
    var key: String
    var endpoint: Endpoint = .live
    
    init() {
        if let path =  Bundle.main.path(forResource: "APIAccess", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) {
            guard let baseUrl: String = dict["baseURL"] as? String,
                let apiKey: String = dict["key"] as? String else {
                    self.baseURL = ""
                    self.key = ""
                    return
            }
            self.baseURL = baseUrl
            self.key = apiKey
        } else {
            self.baseURL = ""
            self.key = ""
        }
    }
    
    func fetchLiveCurrency(completionHandler: @escaping (Result<CurrencyRate>) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, responseError) in
            if let error = responseError {
                completionHandler(.error(error))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Invalid HTTP Response"])))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                //parse data
                do {
                    guard let data = data else {
                        completionHandler(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"No Data from server"])))
                        return
                    }
                    if let currencyRate = try? JSONDecoder().decode(CurrencyRate.self, from: data) {
                        completionHandler(.success(currencyRate))
                    } else {
                        guard let errorMessage = try? JSONDecoder().decode(CurrencyError.self, from: data),
                            let error = errorMessage.error,
                            let code = error.code,
                            let info = error.info else {
                            completionHandler(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Could not parse error message"])))
                                return
                        }
                        completionHandler(.error(NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey:info])))
                    }
                    
                }
            }
            
        }.resume()
    }
}

final class ListCurrencyRepository: ListCurrencyRepositoryProtocol {
    
    var baseURL: String
    var key: String
    var endpoint: Endpoint = .list
    
    init() {
        if let path =  Bundle.main.path(forResource: "APIAccess", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) {
            guard let baseUrl: String = dict["baseURL"] as? String,
                let apiKey: String = dict["key"] as? String else {
                    self.baseURL = ""
                    self.key = ""
                    return
            }
            self.baseURL = baseUrl
            self.key = apiKey
        } else {
            self.baseURL = ""
            self.key = ""
        }
    }
    
    
    func fetchListOfCurrency(completionHandler: @escaping (Result<CurrencyList>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, responseError) in
            if let error = responseError {
                completionHandler(.error(error))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Invalid HTTP Response"])))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    guard let data = data else {
                        completionHandler(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"No Data from server"])))
                        return
                    }
                    if let currencyList = try? JSONDecoder().decode(CurrencyList.self, from: data) {
                        completionHandler(.success(currencyList))
                    } else {
                        guard let errorMessage = try? JSONDecoder().decode(CurrencyError.self, from: data),
                            let error = errorMessage.error,
                            let code = error.code,
                            let info = error.info else {
                            completionHandler(.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:"Could not parse error message"])))
                                return
                        }
                        completionHandler(.error(NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey:info])))
                    }
                    
                }
            }
            
        }.resume()
    }
}
