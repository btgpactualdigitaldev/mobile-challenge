//
//  QuoteModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

struct QuoteModel: Codable {
    let symbol: String
    let price: Double
    let source: String
    let updateDate: Date
}
