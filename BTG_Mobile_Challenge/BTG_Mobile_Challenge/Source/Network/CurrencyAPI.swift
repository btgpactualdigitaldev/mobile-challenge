//
//  CurrencyAPI.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

enum CurrencyAPIEndpoint: String {
    case list = "list?"
    case live = "live?"
}

extension CurrencyAPIEndpoint {
    
    private var accessKey: String { 
       return "access_key=0bda9a8ceb08a7ea5ad4217c645ee12a" 
    }
    
    private var baseUrl: String { 
       return "http://api.currencylayer.com/" 
    }
    
    var url: String? {
        
        switch self {
        case .list:
            let url = "\(baseUrl)\(CurrencyAPIEndpoint.list.rawValue)\(accessKey)"
            return url 
        case .live:
            let url = "\(baseUrl)\(CurrencyAPIEndpoint.live.rawValue)\(accessKey)"
            return url 
        }
    }
}
