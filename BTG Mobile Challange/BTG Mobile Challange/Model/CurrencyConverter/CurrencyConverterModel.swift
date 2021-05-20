//
//  CurrencyConverterModel.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

struct CurrencyConverterModel: Codable {
    let success: Bool?
    let source: String?
    let quotes: [String: Double]?
    let error: ModelError?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case source = "source"
        case quotes = "quotes"
        case error = "error"
    }
}

