//
//  CurrencyLiveResponse.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

struct CurrencyLiveResponse: Decodable {
    let quotes: [String: Double]
}
