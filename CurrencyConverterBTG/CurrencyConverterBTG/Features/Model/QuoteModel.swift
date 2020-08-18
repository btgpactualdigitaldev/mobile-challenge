//
//  QuoteModel.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

struct QuoteModel: Codable {
    let symbol: String
    let price: Double
    let source: String
    let updateDate: Date
}
