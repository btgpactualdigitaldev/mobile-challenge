//
//  CurrencyLayerLiveResponse.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

struct CurrencyLayerLiveResponse: Decodable {
    
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
    
}
