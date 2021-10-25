//
//  Currency.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

struct CurrencyResposnse: Codable {
    var success: Bool
    var terms: String
    var currencies: [String: String]
}

struct Currency: Codable {
    let code: String
    let name: String
}
