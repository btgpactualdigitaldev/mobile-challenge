//
//  LocalStorage.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 19/12/20.
//

import Foundation

@propertyWrapper class LocalStorage<T: Codable> {
    private let userDefaults = UserDefaults.standard
    private let key: UserDefaultsKey

    init(key: UserDefaultsKey) {
        self.key = key
    }

    /// Save a value on UserDefaults using a key
    /// - Parameters:
    ///   - encodable: encodable value
    ///   - key: key for this value
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            userDefaults.set(data, forKey: key)
        }
    }

    /// Returns a value from UserDefaults for a key. If not found, returns nil
    /// - Parameters:
    ///   - type: decodable type
    ///   - key: key for this value
    /// - Returns: decodable value or nil
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = userDefaults.object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }

    var wrappedValue: T? {
        get {
            return value(T.self, forKey: key.rawValue)
        }
        set {
            set(encodable: newValue, forKey: key.rawValue)
        }
    }
}
