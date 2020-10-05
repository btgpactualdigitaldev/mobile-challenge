//
//  LiveCurrencyResponse.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// Representation of the service response for live currency rates
/// based on a source (default: `USD`).
struct LiveCurrencyReponse: Codable {
    let success: Bool
    let terms: URL
    let privacy: URL
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

extension LiveCurrencyReponse: Equatable {
    static func == (lhs: LiveCurrencyReponse, rhs: LiveCurrencyReponse) -> Bool {
        return lhs.success == rhs.success
            && lhs.terms == rhs.terms
            && lhs.privacy == rhs.privacy
            && lhs.timestamp == rhs.timestamp
            && lhs.source == rhs.source
            && lhs.quotes == rhs.quotes
    }
}
