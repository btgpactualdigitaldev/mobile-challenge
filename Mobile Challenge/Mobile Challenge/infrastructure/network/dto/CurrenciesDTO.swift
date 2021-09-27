//
//  CurrenciesDTO.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

struct CurrenciesDTO : Codable {
    let success: Bool
    let currencies: [String: String]
}
