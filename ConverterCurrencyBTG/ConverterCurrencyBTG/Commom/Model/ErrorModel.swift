//
//  ErrorModel.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 06/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    let success: Bool
    let error: ErrorCurrencylayer
}

// MARK: - Error
struct ErrorCurrencylayer: Codable {
    let code: Int
    let info: String
}
