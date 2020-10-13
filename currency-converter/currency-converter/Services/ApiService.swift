//
//  ApiService.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 13/10/20.
//

import Foundation

class ApiService: NSObject {
    
    func getCurrencyValues(completion: @escaping (ResponseCurrencyValues) -> ()) {
        
        let sourcesURL = URL(string: Constants.LiveCurrency)!
        
        URLSession.shared.dataTask(with: sourcesURL) {
            
            (data, response, Error) in
            
            if let data = data  {
                
                print(data)
                
                let result = try! JSONDecoder().decode(ResponseCurrencyValues.self, from: data)
                
                completion(result)
                
            } else  {
                
                completion(ResponseCurrencyValues(success: false, source: "", quotes: [:]))
                
            }
            
        }.resume()
        
    }
    
    func getListCurrency(completion: @escaping (ResponseCurrencyInfo) -> ()) {
        
        let sourcesURL = URL(string: Constants.ListCurrency)!
        
        URLSession.shared.dataTask(with: sourcesURL) {
            
            (data, response, Error) in
            
            if let data = data  {
                
                print(data)
                
                let result = try! JSONDecoder().decode(ResponseCurrencyInfo.self, from: data)
                
                completion(result)
                
            } else  {
                
                completion(ResponseCurrencyInfo(success: false, currencies: [:]))
                
            }
            
        }.resume()
        
    }
    
}
