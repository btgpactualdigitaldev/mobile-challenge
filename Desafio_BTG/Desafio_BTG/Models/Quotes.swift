//
//  Quotes.swift
//  Desafio_BTG
//
//  Created by Kleyson on 11/12/2020.
//  Copyright © 2020 Kleyson. All rights reserved.
//

import Foundation

struct Quotes: Codable  {
    let success: Bool?
    let terms: String?
    let privacy: String?
    let source: String?
    let quotes: [String:Double]?
}
