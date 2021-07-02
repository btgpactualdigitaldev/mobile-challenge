//
//  StorageVariables.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import Foundation

@propertyWrapper struct StorageVariables<T> {
    let key: String
    let defaultValue: T
    let userDefaults = UserDefaults.standard

    init(key: String,
         defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.setValue(newValue, forKey: key)
        }
    }
}
