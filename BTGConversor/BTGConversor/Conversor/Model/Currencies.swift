//
//  Currencies.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

struct Currencies: Codable {
    let success: Bool
    let currencies: [String: String]
}
