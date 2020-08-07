//
//  MockCurrencyData.swift
//  BTGCurrencyTests
//
//  Created by Raphael Martin on 06/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import RealmSwift

class MockCurrencyData: CurrencyDataProtocol {
    func save(quotesResponse: CurrencyQuoteResponse, namesResponse: CurrencyNameResponse) -> Bool {
        return true
    }
    
    func getAll() -> Results<Currency> {
        return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "test")).objects(Currency.self)
    }
    
    func get(forAbbreviation abbreviation: String) -> Currency? {
        return nil
    }
}
