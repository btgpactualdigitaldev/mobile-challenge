//
//  CurrencyModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

struct CurrencyModel {
    let code: String
    let name: String
    var value: Double
    
    func getValuesDict() -> [String: Any] {
        var dict = [String: Any]()
        dict["code"] = code
        dict["name"] = name
        dict["value"] = value
        
        return dict
    }
}
