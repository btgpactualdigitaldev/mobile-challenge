//
//  QuoteList.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 05/10/20.
//

import Foundation

struct QuoteList: Codable {
    let success: Bool
    let error: ErrorApi?
    let source: String?
    let quotes: [String: Float]?
    
    init(success: Bool, error: ErrorApi?, source: String?, quotes: [String: Float]?) {
        self.success = success
        self.error = error
        self.source = source
        self.quotes = quotes
    }
}
