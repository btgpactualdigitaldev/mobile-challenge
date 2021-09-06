//
//  CurrencyListResponse.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

struct CurrencyListResponse: Decodable {
    let currencies: [String: String]
}
