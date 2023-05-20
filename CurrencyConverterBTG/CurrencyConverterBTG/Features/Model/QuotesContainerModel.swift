//
//  QuotesContainerModel.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

struct QuotesContainerModel: Decodable {
    let success: Bool
    let terms: String?
    let privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [QuoteModel]?
    let error: ErrorModel?
    
    private enum QuotesModelKey: String, CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuotesModelKey.self)
        success = try container.decode(Bool.self, forKey: .success)
        terms = try container.decodeIfPresent(String.self, forKey: .terms)
        privacy = try container.decodeIfPresent(String.self, forKey: .privacy)
        timestamp = try container.decodeIfPresent(Int.self, forKey: .timestamp)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        error = try container.decodeIfPresent(ErrorModel.self, forKey: .error)
        
        if error == nil {
            let date: Date = Date.timestampToDate(timestamp: timestamp!)
            
            if let quotesObject: [String: Double] = try container.decodeIfPresent([String: Double].self, forKey: .quotes) {
                var quotes: [QuoteModel] = []
                for (key,value) in quotesObject {
                    let newKey: String = String(key.dropFirst(source!.count))
                    quotes.append(QuoteModel(symbol: newKey, price: value, source: source!, updateDate: date))
                }
                
                self.quotes = quotes
            } else {
                self.quotes = nil
            }
        } else {
            self.quotes = nil
        }
    }
}
