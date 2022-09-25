//
//  ExchangeRate.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 28/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import Foundation

struct CurrentQuote: Decodable {
    let source: String?
    let quotes: [String: Double]?
}

struct Currency {
    let value: Double
    let currency: String
}
