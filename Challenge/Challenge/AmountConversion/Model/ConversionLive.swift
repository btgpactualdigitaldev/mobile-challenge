//
//  ConversionLive.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation

internal struct ConversionLive: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String : Double]
}
