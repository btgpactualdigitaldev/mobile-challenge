//
//  Currency.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

/**
 Model of the currency designed from the API needed attributes.
 */
struct Currency: Codable {
    let name: String
    let symbol: String
}
