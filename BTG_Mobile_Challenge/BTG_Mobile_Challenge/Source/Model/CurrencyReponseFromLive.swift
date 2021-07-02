//
//  CurrencyReponseFromLive.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation

/// Representation of the service response for live currency rates
/// based on a source (default: `USD`).
struct CurrencyReponseFromLive: Decodable {
    let success: Bool
    let terms: URL
    let privacy: URL
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

extension CurrencyReponseFromLive: Equatable {
    static func == (lhs: CurrencyReponseFromLive, rhs: CurrencyReponseFromLive) -> Bool {
        return lhs.success == rhs.success
            && lhs.terms == rhs.terms
            && lhs.privacy == rhs.privacy
            && lhs.timestamp == rhs.timestamp
            && lhs.source == rhs.source
            && lhs.quotes == rhs.quotes
    }
}
