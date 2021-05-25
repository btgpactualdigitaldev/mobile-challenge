//
//  UserDefaultsPersistenceManager.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import Foundation

struct UserDefaultsPersistenceManager: PersistenceManager {
    
    // MARK: - DELETE
    func deleteCurrencies(withKey key: String) -> Bool {
        return deleteItem(withKey: key)
    }
    
    func deleteCurrency(withKey key: String) -> Bool {
        return deleteItem(withKey: key)
    }
    
    func deleteConversionQuotes(withKey key: String) -> Bool {
        return deleteItem(withKey: key)
    }
        
    private func deleteItem(withKey key: String) -> Bool {
        if UserDefaults.standard.data(forKey: key) != nil {
            UserDefaults.standard.removeObject(forKey: key)
            
            return true
        }
        return false
    }
            
    // MARK: - GET
    func getCurrency(withKey key: String) -> Currency? {
        return self.getItem(withKey: key)
    }
    
    func getCurrencies(withKey key: String) -> [Currency]? {
        return self.getItem(withKey: key)
    }
    
    func getConversionQuotes(withKey key: String) -> ConversionQuotes? {
        return self.getItem(withKey: key)
    }
    
    private func getItem<T: Decodable>(withKey key: String) -> T? {
        var t: T?
        
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                t = try JSONDecoder().decode(T.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return t
    }
    
    // MARK: - SAVE
    func saveCurrency(_ currency: Currency, withKey key: String) -> Bool {
        return self.saveItem(withKey: key, itemToBeSaved: currency)
    }
            
    
    func saveCurrencies(_ currencies: [Currency], withKey key: String) -> Bool {
        return self.saveItem(withKey: key, itemToBeSaved: currencies)
    }
    
    func saveConversionQuotes(_ quotes: ConversionQuotes, withKey key: String) -> Bool {
        return saveItem(withKey: key, itemToBeSaved: quotes)
    }
    
    private func saveItem<T: Encodable>(withKey key: String, itemToBeSaved: T) -> Bool {
        do {
            let data = try JSONEncoder().encode(itemToBeSaved)
            UserDefaults.standard.set(data, forKey: key)
            
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
