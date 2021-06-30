//
//  CurrencyConverterViewModel.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

enum CurrencyConverter {
    
    enum Fetch {
        
        struct Request {
            let source: String
        }
        
        struct Response {
            let quotes: CurrencyConverterModel
        }
        
        struct ViewModel {
            let quotes: [String : Float32]
            var orderedQuotes: [String] = []
            var orderedValues: [Float32] = []
            var source: String = ""
            var sourceIndex: Int = 0
            
            init(quotes: CurrencyConverterModel) {
                self.quotes = quotes.quotes
                source = String(self.quotes.first?.key.prefix(3) ?? "")
                orderedQuotes = orderQuotes(quotes: self.quotes)
                orderedValues = orderValues(quotes: self.quotes)
            }
            
            private mutating func orderQuotes(quotes: [String : Float32]) -> [String] {
                let alphabetical = quotes.sorted(by: { $0.0 < $1.0 })
                var result: [String] = []
                for element in alphabetical {
                    let key = String(element.key.suffix(3))
                    if key == source {
                        sourceIndex = result.count
                    }
                    result.append(key)
                }
                return result
            }
            
            private func orderValues(quotes: [String : Float32]) -> [Float32] {
                let alphabetical = quotes.sorted(by: { $0.0 < $1.0 })
                var result: [Float32] = []
                for element in alphabetical {
                    result.append(element.value)
                }
                return result
            }
        }
    }
    
}
