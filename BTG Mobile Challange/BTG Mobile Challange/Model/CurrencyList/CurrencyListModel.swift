//
//  CurrencyListModel.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

struct CurrencyListModel: Codable {
    let success: Bool?
    let error: ModelError?
    let currencies: [String: String]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case error = "error"
        case currencies = "currencies"
    }
}
