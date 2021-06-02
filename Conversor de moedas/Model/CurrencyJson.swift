//
//  CurrencyList.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import Foundation
struct CurrencyJson : Codable {
    let success : Bool?
    let terms : String?
    let privacy : String?
    let currencies : Currencies?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case terms = "terms"
        case privacy = "privacy"
        case currencies = "currencies"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        terms = try values.decodeIfPresent(String.self, forKey: .terms)
        privacy = try values.decodeIfPresent(String.self, forKey: .privacy)
        currencies = try values.decodeIfPresent(Currencies.self, forKey: .currencies)
    }

}
