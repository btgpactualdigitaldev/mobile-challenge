//
//  CurrencyListModel.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import Foundation

// MARK: - currencyListModel
struct CurrencyListModel: Codable {
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]
}
