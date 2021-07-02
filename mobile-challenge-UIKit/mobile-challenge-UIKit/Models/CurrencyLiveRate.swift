//
//  CurrencyLiveRate.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

struct CurrencyLiveRate: Codable {
    enum Keys: String, CodingKey {
        case source, quotes, lastUpdate = "timestamp"
    }

    var source: String
    var lastUpdate: Date
    var quotes: [String: Double]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        source = try container.decode(String.self, forKey: .source)
        quotes = try container.decode([String: Double].self, forKey: .quotes)

        let timeInterval = try container.decode(TimeInterval.self, forKey: .lastUpdate)
        lastUpdate = Date(timeIntervalSince1970: timeInterval)
    }

    func encode(to encoder: Encoder) throws {
        var cont = encoder.container(keyedBy: Keys.self)

        try cont.encode(lastUpdate, forKey: .lastUpdate)
    }
}
