//
//  CurrencyListModel.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

struct Currencies: Codable {
    let currencies: [String: String]
}

struct Currencie {
    let initials: String
    let name: String
}
