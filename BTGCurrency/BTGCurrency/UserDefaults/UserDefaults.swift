//
//  UserDefaults.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

enum UserDefaultKey: String {
    case LocalCurrency = "LocalCurrency"
    case ForeignCurrency = "ForeignCurrency"
    case LastUpdate = "LastUpdate"
}

protocol UserDefaultsProtocol {
    func getString(key: UserDefaultKey) -> String?
    func getDate(key: UserDefaultKey) -> Date?
    func putString(key: UserDefaultKey, value: String) -> Void
    func putDate(key: UserDefaultKey, value: Date) -> Void
}

class AppUserDefaults: UserDefaultsProtocol {
    let preferences = UserDefaults.standard
    
    func getString(key: UserDefaultKey) -> String? {
        return preferences.string(forKey: key.rawValue)
    }
    
    func getDate(key: UserDefaultKey) -> Date? {
        if let _ = preferences.object(forKey: key.rawValue) {
            let unixTimestamp = preferences.double(forKey: key.rawValue)
            if unixTimestamp > 0 {
                return Date(timeIntervalSince1970: unixTimestamp)
            }
        }
        return nil
    }
    
    func putString(key: UserDefaultKey, value: String) {
        preferences.set(value, forKey: key.rawValue)
    }
    
    func putDate(key: UserDefaultKey, value: Date) {
        let unixTimestamp = value.timeIntervalSince1970
        preferences.set(unixTimestamp, forKey: key.rawValue)
    }
}
