//
//  SharedPreference.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 21/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import Foundation

class SharedPreference {
    static let shared = SharedPreference()
    
    private init() {}
    
    func store(currencies: [Currency]) {
        if let data = try? JSONEncoder().encode(currencies) {
            UserDefaults.standard.set(data, forKey: "currencies")
        }
    }
    
    func getStoredCurrencies() -> [Currency]? {
        if let data = UserDefaults.standard.object(forKey: "currencies") as? Data {
            if let currencies = try? JSONDecoder().decode([Currency].self, from: data) {
                return currencies
            }
        }
        return nil
    }
    
    func removeValue(fromKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
