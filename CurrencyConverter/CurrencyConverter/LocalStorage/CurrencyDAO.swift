//
//  CurrencyDAO.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

class CurrencyDAO {
    // MARK: - Properties
    private let userDefaultsManager = UserDefaultsManager()
    
    
    // MARK: - CRUD Methods
    func saveCurrencies(currencies: [Currency]) throws {
        do {
            try userDefaultsManager.saveObject(currencies, forKey: Identifier.Database.name)
        } catch {
            throw error
        }
    }
    
    func fetchCurrencies() throws -> [Currency] {
        do {
            let currencies = try userDefaultsManager.getObject(forKey: Identifier.Database.name, castTo: [Currency].self)
            return currencies
        } catch {
            throw error
        }
    }
}
