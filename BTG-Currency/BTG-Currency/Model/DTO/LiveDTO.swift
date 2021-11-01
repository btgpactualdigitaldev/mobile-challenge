//
//  LiveDTO.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public struct LiveDTO: Decodable {
    var success: Bool?
    var source: String?
    var quotes: [String: Decimal]?
}
