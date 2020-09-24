//
//  APIManager.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 15/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation

class APIManager {
    
    private let baseURL = "http://api.currencylayer.com/"
    
    private func getAPIKey () -> String {
        guard let filePath = Bundle.main.path(forResource: "key", ofType: "plist") else {return ""}
        let plist = NSDictionary(contentsOfFile: filePath)
        let key = plist?.object(forKey: "API_KEY") as? String ?? ""
        return key
    }
    
    func getLiveURL(_ currencyKeyOrigin:String, _ currencyKeyDestiny:String, _ valueToConvert:Double) -> URL {
        return URL(string: "\(baseURL)live?access_key=\(getAPIKey())&currencies=\(currencyKeyOrigin),\(currencyKeyDestiny)&format=1")!
    }
    
    func getListURL() -> URL {
        return URL(string: "\(baseURL)list?access_key=\(getAPIKey())&format=1")!
    }
    
}
