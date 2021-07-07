//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

struct Currency: Codable {
    // MARK: - Properties
    let name: String
    let code: String
    let valueInDollar: Double
}
