//
//  CurrencySearchService.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 14/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

class CurrencySearchService {
    
    var viewModel: CurrencySearchViewModelDelegate?
    
    func getAvailableCurrencies() {
        let url = URL(string: "\(Host.urlString)/list?access_key=\(Host.keyAccess)")
        guard let endpointURL = url else { return }
        var request = URLRequest(url: endpointURL)
        
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let currencies = try? JSONDecoder().decode(Currencies.self, from: data)
                if let currencies = currencies { self.viewModel?.didGetCurrencies(currencies) }
                
            } else if let error = error {
                print(error)
            } else {
                
            }
        }
        
        task.resume()
    }
    
}
