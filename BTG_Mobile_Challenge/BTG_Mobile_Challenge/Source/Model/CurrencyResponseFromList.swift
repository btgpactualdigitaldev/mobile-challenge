//
//  CurrencyResponseFromList.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation

/// Representation of the service response for list supported currencies.
struct CurrencyResponseFromList: Decodable {
    let success: Bool
    let terms: URL
    let privacy: URL
    let currencies: [String: String]
}

extension CurrencyResponseFromList: Equatable {
    static func == (lhs: CurrencyResponseFromList, rhs: CurrencyResponseFromList) -> Bool {
        return lhs.success == rhs.success
            && lhs.terms == rhs.terms
            && lhs.privacy == rhs.privacy
            && lhs.currencies == rhs.currencies
    }
}
