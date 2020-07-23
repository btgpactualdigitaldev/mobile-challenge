//
//  CurrenciesConversionService.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

final class CurrenciesConversionService: NSObject {
    
    func fetchQuotes(success: @escaping (CurrenciesConversion) -> Void,
                     fail: @escaping (_ error: ServiceError) -> Void
    ) {
        
        let serviceUrl = AppEnvironment.domain.value + AppEnvironment.quotes.value
        
        let parameters = ["access_key": "33c0ee51ffd7880ce2b4d1f9e36799ea"] as [String: Any]
        
        ServiceRequest.shared.request(method: .get, url: serviceUrl, parameters: parameters, encoding: .default, success: { result in
            do {
                let list = try JSONDecoder().decode(CurrenciesConversion.self, from: result)
                success(list)
            } catch {
                fail(.init(type: .notMapped))
            }
        }, failure: { serviceError  in
            fail(serviceError)
        })
    }
}
