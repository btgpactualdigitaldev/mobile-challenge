//
//  CurrencyList.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation


struct CurrencyList: Decodable {
    let success: Bool
    var currencies: [String:String]?
}
