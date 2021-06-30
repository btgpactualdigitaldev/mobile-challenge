//
//  UserDefaults.swift
//  CurrencyBuddy
//
//  Created by Rodrigo Giglio on 22/12/20.
//

import Foundation

class UserDefaultsAccess {
    
    // MARK: - Keys
    private static let INPUT_CURRENCY_CODE = "input"
    private static let OUTPUT_CURRENCY_CODE = "output"

    // MARK: - User Defaults
    private static let userDefaults = UserDefaults.standard
    
    // MARK: - Saves
    public static func saveInputCurrencyCode(_ code: String) {
        userDefaults.set(code, forKey: INPUT_CURRENCY_CODE)
    }
    
    public static func saveOutputCurrencyCode(_ code: String) {
        userDefaults.set(code, forKey: OUTPUT_CURRENCY_CODE)
    }
    
    // MARK: - Gets
    public static func getInputCurrencyCode() -> String? {
        userDefaults.string(forKey: INPUT_CURRENCY_CODE)
    }
    
    public static func getOutputCurrencyCode() -> String? {
        userDefaults.string(forKey: OUTPUT_CURRENCY_CODE)
    }
}
