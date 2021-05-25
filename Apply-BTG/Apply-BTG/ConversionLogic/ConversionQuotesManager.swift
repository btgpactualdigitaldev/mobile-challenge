//
//  ConversionLogic.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 23/05/21.
//

import Foundation

struct ConversionQuotesManager {
    // Lazy var!
    private static var conversionQuotes: ConversionQuotes? = {
        var quotes: ConversionQuotes?
        
        if let savedConversionQuotes = UserDefaultsPersistenceManager()
            .getConversionQuotes(withKey: Constants.QUOTES_KEY) {
            
            quotes = savedConversionQuotes
        } else {
            if NetworkManager().hasInternetConnection() {
                NetworkManager().fetchConversionList { q in
                    if let savedQuotes = q {
                        _ = UserDefaultsPersistenceManager().saveConversionQuotes(savedQuotes, withKey: Constants.QUOTES_KEY)
                        quotes = q
                    }
                }
            }
        }
                                
        return quotes
    }()
    
    func convert(value: Double, from origin: String, to destiny: String) -> Double {
        var originValue = value
        var destinyValue: Double = 0.0
                
        if let _ = Self.conversionQuotes {
            if origin == Constants.DOLLAR_KEY {
                destinyValue = self.convertFromDollar(value: originValue, from: destiny)
            } else {
                originValue = self.convertDollarFrom(origin, value: originValue)
                destinyValue = self.convertFromDollar(value: originValue, from: destiny)
            }
        }
                                        
        return destinyValue
    }
    
    private func convertFromDollar(value: Double, from currencyCode: String) -> Double {
        let key = "\(Constants.DOLLAR_KEY)\(currencyCode)"
                        
        return value * (Self.conversionQuotes?.all[key] ?? 0.0)
    }
    
    private func convertDollarFrom(_ currencyCode: String, value: Double) -> Double {
        let key = "\(Constants.DOLLAR_KEY)\(currencyCode)"
                        
        return value / (Self.conversionQuotes?.all[key] ?? 0.0)
    }
}
