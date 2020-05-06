//
//  Configured.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

@propertyWrapper
struct Configured<Value> where Value: Codable {
    
    private let valueKey: String
    private let storage: UserDefaults = .standard
    private let defaultValue: Value
    
    var wrappedValue: Value {
        set { storage.set(try! JSONEncoder().encode(newValue), forKey: valueKey) }
        get {
            if let data = storage.data(forKey: valueKey) {
                return try! JSONDecoder().decode(Value.self, from: data)
            }
            
            return defaultValue
        }
    }
    
    init(valueKey: String, defaultValue: Value) {
        self.valueKey = valueKey
        self.defaultValue = defaultValue
    }
}
