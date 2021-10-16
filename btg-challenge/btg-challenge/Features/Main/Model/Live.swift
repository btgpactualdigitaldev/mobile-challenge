//
//  MainModel.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

struct Live: Codable {
    let success: Bool?
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?
}
