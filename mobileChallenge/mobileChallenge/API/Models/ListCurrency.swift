//
//  ListCurrency.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 02/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import Foundation

struct ListCurrency: Codable {
    var success: Bool
    var terms, privacy: URL
    var currencies: [String: String]
}

struct Currency: Codable {
    let code: String
    let name: String
    
    static func getListCurrency(currencies: [String: String]) -> [Currency] {
        var listCurrency: [Currency] = []
        currencies.forEach {
            let list = Currency(code: $0.key, name: $0.value)
            listCurrency.append(list)
        }
        return listCurrency
    }
}
