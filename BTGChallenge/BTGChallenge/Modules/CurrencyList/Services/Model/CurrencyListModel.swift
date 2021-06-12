//
//  CurrencyModel.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 12/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation

// MARK: - CurrencyListModel
struct CurrencyListModel: Codable {
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]?
}
