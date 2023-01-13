//
//  CurrencyAPI.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

protocol CurrencyAPIProtocol {
    func fetchCurrencyList(callback: @escaping (Result<CurrencyList>) -> Void)
    func fetchQuotes(callback: @escaping (Result<QuoteList>) -> Void)
}

class CurrencyAPI {
    
    static var shared: CurrencyAPI = CurrencyAPI()
    let network = Network()
    
    private init() { }
    
}

extension CurrencyAPI: CurrencyAPIProtocol {
    
    func fetchCurrencyList(callback: @escaping (Result<CurrencyList>) -> Void)  {
        
        let url = getURL(path: "list")
        
        self.network.request(url: url, method: .get, callback: callback)
    }
    
    func fetchQuotes(callback: @escaping (Result<QuoteList>) -> Void)  {
        
        let url = getURL(path: "live")
        
        self.network.request(url: url, method: .get, callback: callback)
    }
    
}

extension CurrencyAPI {
    
    private func getURL(path: String) -> String {
        return "\(Constraints.URI.rawValue)/\(path)?access_key=\(Constraints.acessKey.rawValue)"
    }
}
