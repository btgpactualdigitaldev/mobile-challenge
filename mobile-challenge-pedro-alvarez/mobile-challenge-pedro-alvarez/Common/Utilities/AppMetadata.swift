//
//  AppMetadata.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

struct AppMetadata {
    
    private var userDefaults: UserDefaults = UserDefaults.standard
    
    var isFirstTimeInApp: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaults.firstTime)
    }
    
    func consumeFirstTime() {
        userDefaults.set(true, forKey: Constants.UserDefaults.firstTime)
    }
}
