//
//  CurrencyListResponse.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

struct CurrencyListResponse: Decodable {
    let success: Bool
    let error: ErrorResponse?
    var currencies: [String:String]?
}
