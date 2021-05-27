//
//  CurrenciesPersistenceRepository.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RealmSwift

protocol CurrenciesPersistenceRepository {
    func getCurrencies() -> Results<CurrencyModel>
    func saveAll(currencies: [CurrencyModel])
}
