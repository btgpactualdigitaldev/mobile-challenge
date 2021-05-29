//
//  UserDefaults+CustomProperties.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import Foundation

extension UserDefaults {
    static var hasStoredEntities: Bool {
        get {
            UserDefaults.standard.bool(forKey: "hasStoredEntities")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasStoredEntities")
        }
    }
}
