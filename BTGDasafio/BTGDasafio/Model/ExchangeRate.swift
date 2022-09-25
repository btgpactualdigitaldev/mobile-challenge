//
//  ExchangeRate.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 28/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import Foundation

struct ExchangeRate: Decodable {
    let currencies: [String: String]?
}

struct Coins {
    let code: String?
    let country: String?
}
