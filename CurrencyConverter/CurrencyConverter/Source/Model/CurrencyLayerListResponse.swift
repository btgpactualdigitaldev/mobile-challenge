//
//  CurrencyLayerListResponse.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

struct CurrencyLayerListResponse: Decodable {
    
    let success: Bool
    let currencies: [String: String]
    
}
