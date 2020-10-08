//
//  CurrentQuoteResponseModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 06/10/20.
//

import Foundation

struct CurrentQuoteResponseModel: Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var timestamp: Int?
    var source: String?
    var quotes: [String: Double]?
}
