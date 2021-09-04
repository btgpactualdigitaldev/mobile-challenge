//
//  GetRatesResponse.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import Foundation

typealias Quotes = [String:Double]

// MARK: Get Rate List
class GetRatesResponse: Codable {
    var success: Bool?
    var source: String?
    var quotes: Quotes?
    
    init(_ success: Bool?, _ source: String?, _ quotes: Quotes?) {
        self.success = success
        self.source = source
        self.quotes = quotes
    }
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case source = "source"
        case quotes = "quotes"
    }
}
