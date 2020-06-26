//
//  LiveQuoteModel.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

struct LiveQuoteRates: Codable, Hashable {
        let success: Bool
        let terms: URL
        let privacy: URL
        let timestamp: Date
        let source: String
        let quotes: [String : Double]
}
