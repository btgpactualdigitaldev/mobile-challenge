//
//  LiveExchange.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

struct LiveExchange: Codable {
    
    let success: Bool?
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?

}
