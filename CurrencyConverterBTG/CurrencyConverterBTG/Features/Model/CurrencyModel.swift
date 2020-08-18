//
//  CurrencyModel.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

struct CurrencyModel: Codable {
    let symbol: String
    let descriptionCurrency: String
}


// MARK: - CustomStringConvertible


extension CurrencyModel: CustomStringConvertible {
    
    var description: String {
        return "\(symbol.uppercased()) / \(descriptionCurrency)"
    }
}


// MARK: - Equatable


extension CurrencyModel: Equatable {
    static func == (lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.symbol.lowercased() == rhs.symbol.lowercased()
    }
}
