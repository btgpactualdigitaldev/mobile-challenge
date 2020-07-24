//
//  Quotes.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 23/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

struct Quotes: Codable, Hashable {
    let list: [String: Double]
    let lastUpdate: Date
    var isValid: Bool {
        return Date(timeInterval: 86400, since: lastUpdate) > Date()
    }
    
    init(list: [String: Double])
    {
        self.list = list
        lastUpdate = Date()
    }
    
}

