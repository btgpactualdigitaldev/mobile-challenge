//
//  ViewController.swift
//  CurrencyBuddy
//
//  Created by Rodrigo Giglio on 21/12/20.
//

import Foundation

enum API {
    
    static var currentScheme: API = .development
    public static let apiKey: String = "d42c54f23e4798602e3c58a84d29e10f"
    
     /// For staging and production builds, the API URL
     /// must me defined here
    case development
    
    var url: String {
        
        switch self {
            case .development: return "http://apilayer.net/api"
        }
    }
}
