//
//  GetResponse.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import Foundation

typealias Currencies = [String:String]

// MARK: get Coin List
class GetCoinsResponse: Codable {
    var success: Bool?
    var currencies: Currencies?
    
    init(_ success: Bool?, _ currencies: Currencies?) {
        self.success = success
        self.currencies = currencies
    }
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case currencies = "currencies"
    }
}
