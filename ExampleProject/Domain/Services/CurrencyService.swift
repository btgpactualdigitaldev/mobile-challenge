//
//  CurrencyService.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 07/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation

enum CurrencyService<T: ApiCall>: String {
    case live
    case list
    
    func http(_ escaping: @escaping (ApiResponse<T>) -> Void)  {
        print("\(self.baseUrl())\(self.rawValue)\(self.apiKey())")
        let url = URL(string: "\(self.baseUrl())\(self.rawValue)\(self.apiKey())")
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let _ = error {
                escaping(ApiResponse.failure(ApiError(.unknown)))
                return
            }
            
            guard let data = data else { return escaping(.failure(ApiError(.unknown))) }
            
            guard let apiCall = try? JSONDecoder().decode(T.self, from: data) else { return escaping(.failure(ApiError(.parseFailed))) }
            
            if apiCall.success {
                escaping(.success(apiCall))
            } else {
                guard let apiError = apiCall.error else { return escaping(.failure(ApiError(.parseFailed))) }
                escaping(.failure(apiError))
            }
            
        }).resume()
    }

    private func baseUrl() -> String {
        return "http://api.currencylayer.com/"
    }
    
    private func apiKey() -> String {
        return "?access_key=9faa43b88931753ab66f6d75000af915"
    }
}
