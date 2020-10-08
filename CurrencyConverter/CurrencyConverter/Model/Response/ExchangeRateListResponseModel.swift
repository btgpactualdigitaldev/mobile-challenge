//
//  ExchangeRateListResponseModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 06/10/20.
//

import Foundation

struct ExchangeRateListResponseModel: Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var currencies: [String: String]?
}
