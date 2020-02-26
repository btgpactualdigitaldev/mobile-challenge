//
//  CurrencyDataProvider.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

enum CurrencyError: Error{
    case noDataAvailable
    case canNotProccessData
}

struct CurrencyDataProvider {
    
    private let BASE_URL = "http://api.currencylayer.com/"
    private let resourceURL:URL
    private let API_KEY = "c69f0dacc7b5c7cc0b46d694fbe03831"

    init(from: String? = nil, to: String? = nil) {
        
        let resourceString = "\(BASE_URL)live?access_key=\(API_KEY)&currencies=USD,\(from ?? "USD"),\(to ?? "USD")&format=1"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }

    //MARK: - GETTING THE CURRENT VALUE OF CHOSEN CURRENCY
    func getCurrentCurrencyValue(completion: @escaping(Result<LiveExchange, CurrencyError>) -> Void) {
                
        URLSession.shared.dataTask(with: self.resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do{
                let updateExchange = try JSONDecoder().decode(LiveExchange.self, from: jsonData)
                completion(.success(updateExchange))
            }catch{
                completion(.failure(.canNotProccessData))
            }
            
        }.resume()
        
    }
    
    //MARK: - GETTING THE CURRENCY LIST
    
    func getListOfCurrencies(completion: @escaping(Result<[String : String], CurrencyError>) -> Void){
        
        guard let url = URL(string: "\(BASE_URL)list?access_key=\(API_KEY)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(CurrencyList.self, from: jsonData)
                if let currencies = decoded.currencies {
                    completion(.success(currencies))
                }
            }
            catch{
                completion(.failure(.canNotProccessData))
            }
            
        }.resume()
        
    }
    
}
