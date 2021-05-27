//
//  CurrenciesPersistenceMock.swift
//  CurrencyConverterTests
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RealmSwift
@testable import Currencies

class CurrenciesPersistenceMock: CurrenciesPersistenceRepository {
    let currenciesPersistence = CurrenciesPersistence()
    
    func getCurrencies() -> Results<CurrencyModel> {
        return currenciesPersistence.getCurrencies()
    }
    
    func saveAll(currencies: [CurrencyModel]) {
        currenciesPersistence.saveAll(currencies: currencies)
    }
}
