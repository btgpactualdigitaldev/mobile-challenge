//
//  ApiService.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 04/11/20.
//

import Foundation

class ApiService: NSObject {
    
    func getSupportedCurrencies(completion: @escaping (ResponseCurrencyData) -> ()) {
        
        let urlRequest = URL(string: Constants.SupportedCurrenciesList)!
        
        URLSession.shared.dataTask(with: urlRequest) {
            
            (data, response, error) in
            
            if let data = data {
                
                let decoder = JSONDecoder()
                
                let result = try! decoder.decode(ResponseCurrencyData.self, from: data)
                completion(result)
                
            } else {
                completion(ResponseCurrencyData(success: false, terms: "", privacy: "", currencies: [:]))
            }
   
        }.resume()
        
    }
    
    func getRealTimeRates(completion: @escaping (ResponseRatesData) -> ()) {
        
        let urlRequest = URL(string: Constants.LiveCurrency)!
        
        URLSession.shared.dataTask(with: urlRequest) {
            
            (data, response, error) in
            
            if let data = data {
                
                let decoder = JSONDecoder()
                
                let result = try! decoder.decode(ResponseRatesData.self, from: data)
                completion(result)
                
            } else {
                completion(ResponseRatesData(success: false, source: "", quotes: [:]))
            }
   
        }.resume()
        
    }
    
}

struct ResponseCurrencyData: Decodable {
    
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: [String: String]

    
}

struct ResponseRatesData: Decodable {
    let success: Bool
    let source: String
    let quotes: [String: Float]
}
