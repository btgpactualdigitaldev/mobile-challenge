//
//  CurrenciesViewModel.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

import Foundation

class CurrenciesViewModel {
    
    var currencies: [String: String] = [:]
    
    func fetchAllCurrencies(completionHandler: @escaping (Result<[String: String], APIError>) -> Void) {
        let request = APIRequest()
        
        request.fetchAllCurrencies { (result) in
            
            switch result {
            
            case .success(let currencies):
                completionHandler(.success(currencies ?? [:]))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
