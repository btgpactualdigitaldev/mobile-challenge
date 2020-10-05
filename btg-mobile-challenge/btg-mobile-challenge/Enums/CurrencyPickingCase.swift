//
//  CurrencyPickingCase.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

/// All possible currency picking cases.
/// The `.rawValue` are used as keys for local key-value storage.
enum CurrencyPickingCase: String {
    case from = "from-currency"
    case to = "to-currency"
}
