//
//  ListDTO.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public struct ListDTO: Decodable {
    var success: Bool?
    var currencies: [String: String]?
}
