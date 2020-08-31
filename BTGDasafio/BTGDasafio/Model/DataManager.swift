//
//  Manager.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 30/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import UIKit

class DataManager {
    private let currenciesKey = "currencies"
    private let quotesKey = "quotes"
    private let defaults = UserDefaults.standard
    private static var _instance: DataManager?
    static var instance: DataManager {
        get {
            if _instance == nil {
                _instance = DataManager()
            }
            return _instance!
        }
    }

    func getCurrencies() -> [String: String]? {
        return defaults.object(forKey: currenciesKey) as? [String: String]? ?? [:]
    }

    func getQuotes() -> [String: Double]? {
        return defaults.object(forKey: quotesKey) as? [String: Double]? ?? [:]
    }

    func setCurrencies(currencies: [String: String]?) {
        defaults.set(currencies ?? [:], forKey: currenciesKey)
    }

    func setQuotes(quotes: [String: Double]?) {
        defaults.set(quotes ?? [:], forKey: quotesKey)
    }
}
