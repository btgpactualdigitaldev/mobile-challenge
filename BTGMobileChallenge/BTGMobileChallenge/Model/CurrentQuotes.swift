//
//  CurrentCurrencies.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import Foundation

class CurrentQuotes: Decodable {
	let success: Bool
	let source: String
	let quotes: [String: Float]
}
