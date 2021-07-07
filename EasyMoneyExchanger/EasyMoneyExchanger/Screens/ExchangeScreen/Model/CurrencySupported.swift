//
//  SupportedCurrenciesModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation

struct CurrencySupported: Codable {
    let currencies: [String: String]
}
