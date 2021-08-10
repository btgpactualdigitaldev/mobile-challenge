//
//  AvaliableCurrencies.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import Foundation

struct AvaliableQuotes: Decodable {
	let success: Bool
	let currencies: [String: String]
}
