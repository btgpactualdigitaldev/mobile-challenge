//
//  LiveQuotes.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

struct LiveQuotes: Codable, Hashable {
    let quotes: [String: Double]
}
