//
//  PersistenceManager.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import Foundation

protocol PersistenceManager {
    func saveCurrency(_ currency: Currency, withKey key: String) -> Bool
    func getCurrency(withKey key: String) -> Currency?
    func deleteCurrency(withKey key: String) -> Bool
    
    func saveCurrencies(_ currencies: [Currency], withKey key: String) -> Bool
    func getCurrencies(withKey key: String) -> [Currency]?
    func deleteCurrencies(withKey key: String) -> Bool
    
    func saveConversionQuotes(_ quotes: ConversionQuotes, withKey key: String) -> Bool
    func getConversionQuotes(withKey key: String) -> ConversionQuotes?
    func deleteConversionQuotes(withKey key: String) -> Bool
}
