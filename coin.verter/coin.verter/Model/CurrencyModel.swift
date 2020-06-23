//
//  CurrencyModel.swift
//  coin.verter
//
//  Created by Caio Berkley on 23/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import Foundation

struct Currency {
    
    var key, value: String

}

struct CurrencyList: Codable {
    
    let success: Bool?
    let terms, privacy: String?
    let currencies: [String: String]?

}
