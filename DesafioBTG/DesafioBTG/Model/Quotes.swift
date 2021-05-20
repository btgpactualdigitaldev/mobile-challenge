//
//  Quotes.swift
//  DesafioBTG
//
//  Created by Any Ambria on 13/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import Foundation

struct Quotes: Codable {
    let success: Bool?
    let terms: String?
    let privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?
    let error: Error?
}
