//
//  DataProvider.swift
//  coin.verter
//
//  Created by Caio Berkley on 23/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import Foundation

enum CurrencyError: Error{
    case noDataAvailable
    case canNotProccessData
}

struct DataProvider {
    
    private let BASE_URL = "http://api.currencylayer.com/"
    private let API_KEY = "9ca7babccb423cbb2d31be3d6105eff5"
    private let resourceURL:URL

    init(from: String? = nil, to: String? = nil) {
        
        let resourceString = "\(BASE_URL)live?access_key=\(API_KEY)&currencies=USD,\(from ?? "USD"),\(to ?? "USD")&format=1"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    
    //MARK - GET CURRENCY LIST
    
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
    
    //MARK - GET CURRENT VALUE OF CHOSEN CURRENCY
       func getCurrentCurrencyValue(completion: @escaping(Result<LiveExchangeModel, CurrencyError>) -> Void) {
                   
           URLSession.shared.dataTask(with: self.resourceURL) { data, response, error in
               
               guard let jsonData = data else {
                   completion(.failure(.noDataAvailable))
                   return
               }
               
               do{
                   let updateExchange = try JSONDecoder().decode(LiveExchangeModel.self, from: jsonData)
                   completion(.success(updateExchange))
               }catch{
                   completion(.failure(.canNotProccessData))
               }
               
           }.resume()
           
       }
    
}
