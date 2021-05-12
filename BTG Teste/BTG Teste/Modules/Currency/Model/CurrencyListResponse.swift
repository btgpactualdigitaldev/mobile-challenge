//
//  CurrencyListResponse.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

class CurrencyListResponse: Codable {
    var success: Bool
    var terms: String
    var privacy: String
    var currencies: [String:String]
}
