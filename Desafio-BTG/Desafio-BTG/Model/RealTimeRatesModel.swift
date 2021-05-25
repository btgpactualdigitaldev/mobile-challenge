//
//  RealTimeRatesModel.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import Foundation

// MARK: - RealTimeRatesModel
struct RealTimeRatesModel: Codable {
    let success: Bool
    let terms, privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
