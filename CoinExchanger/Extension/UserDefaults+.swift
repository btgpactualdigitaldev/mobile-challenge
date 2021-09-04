//
//  UserDefaults+.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 08/12/20.
//

import Foundation

extension UserDefaults {
    
    public enum Keys {
        static let date = "kDate"
        static let origin = "kOrigin"
        static let target = "kTarget"
        static let reset = "kReset"
    }
    
    var date: String {
        get { return string(forKey: Keys.date) ?? "" }
        set {
            set(newValue, forKey: Keys.date)
            _ = synchronize()
        }
    }
    
    var origin: String {
        get { return string(forKey: Keys.origin) ?? "" }
        set {
            set(newValue, forKey: Keys.origin)
            _ = synchronize()
        }
    }
    
    var target: String {
        get { return string(forKey: Keys.target) ?? "" }
        set {
            set(newValue, forKey: Keys.target)
            _ = synchronize()
        }
    }
    
    var reset: Bool {
        get { return bool(forKey: Keys.reset) }
        set {
            set(newValue, forKey: Keys.reset)
            _ = synchronize()
        }
    }
    
}
