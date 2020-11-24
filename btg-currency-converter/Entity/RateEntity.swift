//
//  RateEntity.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 24/11/20.
//

import Foundation

struct RateEntity: Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var timestamp: Int?
    var source: String?
    var quotes: [String: Double]?
}
