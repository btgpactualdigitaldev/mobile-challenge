//
//  ExchangeViewModel.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

class ExchangeViewModel {
    
    var usedExchanges: [String: Double] = [:]
    var allExchanges: [String: Double] = [:]

    func fetchAllExchanges(completionHandler: @escaping (Result<[String: Double], APIError>) -> Void) {
        let request = APIRequest()
        
        request.fetchAllExchanges(completionHandler: { (result) in
            
            switch result {
            
            case .success(let exchanges):
                completionHandler(.success(exchanges ?? [:]))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func fetchSpecificExchanges(currencyCodes: [String], completionHandler: @escaping (Result<[String: Double], APIError>) -> Void) {
        let request = APIRequest()
        
        request.fetchSpecificExchanges(currencyCodes: currencyCodes, completionHandler: { (result) in
            
            switch result {
            
            case .success(let exchanges):
                completionHandler(.success(exchanges ?? [:]))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func exchangeResult(value: String) -> Double{
        
        guard let value = Double(value) else {
            return 0
        }
        
        let result = (value * (usedExchanges[0].value / usedExchanges[1].value))
        
        return result
    }
    
    func compareTitles(firstTitle: String, secondTitle: String) -> Bool{
        
        return firstTitle == secondTitle
    }
}
