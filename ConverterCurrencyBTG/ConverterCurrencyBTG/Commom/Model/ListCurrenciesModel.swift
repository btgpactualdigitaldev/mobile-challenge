//
//  ListCurrenciesModel.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 01/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

struct ListCurrenciesModel: Codable {
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]
}
