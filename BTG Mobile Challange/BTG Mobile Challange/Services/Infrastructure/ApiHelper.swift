//
//  ApiHelper.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

struct ApiHelper {
    static var baseURL: String = "http://api.currencylayer.com"

    static let connectionTimeout: Double = 60

    static var currencyApiKey: String {
        guard let apiKeyPlist = Bundle.main.path(forResource: "api_key", ofType: "plist") else { return "" }
        let dictionary = NSDictionary(contentsOfFile: apiKeyPlist)
        guard let value = dictionary?["currencyApiKey"] as? String else { return "" }
        return value
    }
}
