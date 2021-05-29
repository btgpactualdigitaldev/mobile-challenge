//
//  UserDefaults+CustomProperties.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation

extension UserDefaults {
    
    static var timeStamp: Double {
        get {
            UserDefaults.standard.double(forKey: "timeStamp")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "timeStamp")
        }
    }
}
