//
//  CurrencyLayerResponses.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import Foundation

struct CurrencyLayerConvertResponse: Codable {
    let success: Bool?
    let quotes: [String: Double]?
}

struct CurrencyLayerListResponse: Codable {
    let success: Bool?
    let currencies: [String: String]?
}

struct Currency: Codable {
    let title: String
    let description: String?
}
