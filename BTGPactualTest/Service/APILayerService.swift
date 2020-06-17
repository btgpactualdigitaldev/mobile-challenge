//
//  Service.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 10/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct APILayerEndpoint {
    static let baseUrl = "http://apilayer.net/api/"
    static let accessKey = "bf209dbb1969bf1660a78cc97cc77342"
    
    static var baseURLComponent: URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "apilayer.net"
        urlComponent.path = "/api"
        urlComponent.queryItems = [URLQueryItem(name: "access_key",
                                                value: APILayerEndpoint.accessKey)]
        return urlComponent
    }
    
    
    static var currencyEndpoint: URLComponents {
        var component = APILayerEndpoint.baseURLComponent
        component.path.append("/list")
        
        return component
    }
    
    static var quoteEndpoint: URLComponents {
        var component = APILayerEndpoint.baseURLComponent
        component.path.append("/live")
        
        return component
    }
}

enum ServiceError: Error {
    case request
    case currencyLayerApi
    case decoding
    
    var localizedDescription: String {
        switch self {
        case .currencyLayerApi:
            return "Erro ao conectar em apilayer.net"
        
        case .decoding:
            return "Erro ao decodificar JSON"
        
        case .request:
            return "Erro ao realizar requisição"
        }
    }
}

class APILayerService {
    typealias CurrencyCallback = ((Result<[Currency], ServiceError>) -> Void)
    typealias ConvertCallback = ((Result<[String: Quote], ServiceError>) -> Void)
    
    func getQuotes(completionHandler: @escaping ConvertCallback) {


        let task = URLSession.shared.dataTask(with: APILayerEndpoint.quoteEndpoint.url!) {(data, response, error) in
            guard let data = data else {
                completionHandler(.failure(ServiceError.request))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(QuoteResponse.self, from: data)
                
                
                if response.success {
                    DispatchQueue.main.async {
                        completionHandler(.success(response.getQuotes()))
                    }
               
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.currencyLayerApi))
                    }
                }
                
                
                
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.decoding))
                }
                
            }
            
        }

        task.resume()
        
    }
    
    func getList(completionHandler: @escaping CurrencyCallback) {
        
        let task = URLSession.shared.dataTask(with: APILayerEndpoint.currencyEndpoint.url!) {(data, response, error) in
            guard let data = data else {
                completionHandler(.failure(ServiceError.request))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CurrencyResponse.self, from: data)
                
                
                if response.success {
                    DispatchQueue.main.async {
                        completionHandler(.success(response.getCurrencies()))
                    }
               
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.currencyLayerApi))
                    }
                }
                
                
                
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.decoding))
                }
                
            }
            
        }

        task.resume()
    }
    
    
}
