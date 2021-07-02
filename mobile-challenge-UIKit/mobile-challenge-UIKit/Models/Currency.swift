//
//  Currency.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

struct Currency: Codable {
    let code, name: String

    // MARK: - Two default currencies
    static var usd: Currency {
        return Currency(code: "USD", name: "United States Dollar")
    }

    static var brl: Currency {
        return Currency(code: "BRL", name: "Brazilian Real")
    }
}
