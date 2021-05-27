//
//  CurrenciesPersistence.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import RealmSwift

final class CurrenciesPersistence: CurrenciesPersistenceRepository {
    private let realm = try! Realm()

    func getCurrencies() -> Results<CurrencyModel> {
        return realm.objects(CurrencyModel.self)
    }
    
    func saveAll(currencies: [CurrencyModel]) {
        do {
            try realm.write {
                realm.add(currencies, update: .all)
            }
        } catch let error {
            print(error)
        }
    }
}
