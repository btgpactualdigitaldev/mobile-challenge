//
//  CurrentDollarQuoteDTO.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

struct CurrentDollarQuoteDTO: Codable {
    let success: Bool
    let source: String
    let quotes: [String: Double]
}
