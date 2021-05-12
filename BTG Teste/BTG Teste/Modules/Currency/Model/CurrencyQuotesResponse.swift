//
//  CurrencyQuotesResponse.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

class CurrencyQuotesResponse: Codable {
    var success: Bool
    var terms: String
    var privacy: String
    var timestamp: Int
    var source: String
    var quotes: [String:Double]
}
