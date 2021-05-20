//
//  CurrenciesProvider.swift
//  DesafioBTG
//
//  Created by Any Ambria on 12/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import Foundation

protocol CurrenciesProviderProtocol {
    func fetchListCurrencies(completionHandler: @escaping (Result<Currencies>) -> Void)
    func fetchQuotesCurrencies(completionHandler: @escaping (Result<Quotes>) -> Void)
}

class CurrenciesProvider: CurrenciesProviderProtocol {
    func fetchListCurrencies(completionHandler: @escaping (Result<Currencies>) -> Void) {
        guard let url = URL(string: "http://api.currencylayer.com/list?access_key=79e7566f5afdcb0a612d551c5084cfa9")
            else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Currencies.self, from: data)
                completionHandler(.success(json))
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchQuotesCurrencies(completionHandler: @escaping (Result<Quotes>) -> Void) {
        guard let url = URL(string: "http://api.currencylayer.com/live?access_key=79e7566f5afdcb0a612d551c5084cfa9")
            else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Quotes.self, from: data)
                completionHandler(.success(json))
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
