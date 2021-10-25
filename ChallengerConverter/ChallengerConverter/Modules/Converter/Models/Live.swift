//
//  Live.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation


struct LiveResult: Codable {
    var success: Bool
    var terms: String
    var timestamp: Double
    var source: String
    var quotes: [String: Double]
}


struct Quotes: Codable {
    let code: String
    let quote: Double
}
