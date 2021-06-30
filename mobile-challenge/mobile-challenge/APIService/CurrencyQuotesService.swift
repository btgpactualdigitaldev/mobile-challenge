//
//  CurrencyService.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

class CurrencyService {
    
    /**
     Performs a request to the Currency API and returns CurrencyQuotes.
     
     - Parameter completion: The block of code that will be executed after the get request is executed.
     
     */
    public static func getQuotes(completion: @escaping (TaskAnswer<Any>) -> Void) {
        
        private static let endpoint = "live"
        
        // Specify API access key
        let accesKeyQuery = URLQueryItem(name: "access_key", value: CurrencyAPI.accessKey)
        
        Requests.getRequest(url: CurrencyAPI.url, endpoint: endpoint, decodableType: CurrencyQuotes.self, queries: [accesKeyQuery]) { (answer) in
            completion(answer)
        }
    }
    
    public static func getCurrencyList() {
        
        private static let endpoint = "list"
        
        // Specify API access key
        let accesKeyQuery = URLQueryItem(name: "access_key", value: CurrencyAPI.accessKey)
        
        Requests.getRequest(url: CurrencyAPI.url, endpoint: endpoint, decodableType: CurrencyQuotes.self, queries: [accesKeyQuery]) { (answer) in
            completion(answer)
        }
        
    }
}
