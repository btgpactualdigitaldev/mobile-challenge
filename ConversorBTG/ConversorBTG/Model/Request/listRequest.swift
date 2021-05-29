//
//  CurrencyRequest.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import Foundation

struct ListRequest:Codable {
    let success : Bool
    let currencies: CurrencyListResult
}


struct CurrencyListResult: Codable{
    let id : String
    let name: String
}

struct LiveRequest:Codable {
    let success: Bool
    let quotes: CurrencyLiveResult
}


struct CurrencyLiveResult: Codable{
    let id : String
    let value: Decimal
}
