//
//  LiveExchangeModel.swift
//  coin.verter
//
//  Created by Caio Berkley on 23/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import Foundation

struct LiveExchangeModel: Codable {
    
    let success: Bool?
    let terms, privacy, source: String?
    let timestamp: Int?
    let quotes: [String: Double]?

}

