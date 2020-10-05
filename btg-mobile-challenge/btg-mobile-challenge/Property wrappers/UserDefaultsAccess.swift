//
//  UserDefaultsAccess.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

/// Property wrapper responsible for providing type-safe access to `UserDefaults`.
/// By default, it is initialized with `UserDefaults.shared`. When testing, mock
/// `UserDefaults` through the `UserDefaultsService` protocol.
@propertyWrapper struct UserDefaultAccess<T> {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaultsService

    /// Initializes a new instance of this type.
    /// - Parameter key: The key to be accessed.
    /// - Parameter defaultValue: The default value for the key.
    /// - Parameter userDefaults: The instance of `UserDefaultsService`. Defaults to
    /// `UserDefaults.standard`.
    init(key: String,
         defaultValue: T,
         userDefaults: UserDefaultsService = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
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

/// The service responsible for providing access to storage.
protocol UserDefaultsService {
    func object(forKey: String) -> Any?
    func setValue(_ value: Any?, forKey key: String)
}
