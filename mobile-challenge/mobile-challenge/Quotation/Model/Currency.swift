//
//  Currency.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 26/11/20.
//

import Foundation

struct Currency: Decodable {
    var success: Bool
    var error: ErrorCode?
    var currencies: [String: String]
}
