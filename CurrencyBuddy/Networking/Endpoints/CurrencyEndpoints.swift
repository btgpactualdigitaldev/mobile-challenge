//
//  ViewController.swift
//  CurrencyBuddy
//
//  Created by Rodrigo Giglio on 21/12/20.
//

import Foundation
import Moya

enum CurrencyEndpoints: TargetType {
    
    case list
    case live
    
    var path: String {
        
        switch self {
        
        case .list: return "/list"
        case .live: return "/live"
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        
        case .list: return .get
        case .live: return .get
        }
    }
    
    var task: Task {
        
        let parameters = [
            "access_key": API.apiKey
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
}
