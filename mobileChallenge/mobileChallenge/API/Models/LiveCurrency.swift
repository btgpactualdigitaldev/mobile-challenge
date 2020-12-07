//
//  LiveCurrency.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 02/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import Foundation

struct LiveCurrency: Codable {
    var success: Bool
    var terms, privacy: URL
    var timestamp: Int
    var source: String
    var quotes: [String: Double]
}

struct Live: Codable {
    let code: String
    let quote: Double
    
    static func getLiveCurrency(lives: [String: Double]) -> [Live] {
        var liveCurrency: [Live] = []
        lives.forEach {
            let live = Live(code: String($0.key.suffix(3)), quote: $0.value)
            liveCurrency.append(live)
        }
        return liveCurrency
    }
    
    static func findBy(code: String) -> Live? {
        let currencies = UserDefaults.LCurrency.lives
        return currencies.first { $0.code == code }
    }

}

