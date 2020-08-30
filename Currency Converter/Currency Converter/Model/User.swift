//
//  CurrentCurrencies.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {

    @objc dynamic var objectID: String? = nil
    override static func primaryKey() -> String? {
        return "objectID"
    }

    @objc dynamic var fromCurrency = "USD"
    @objc dynamic var toCurrency = "BRL"

    class func createIfNeeded(realm: Realm) -> User {

        if let localObject = realm.object(ofType: User.self, forPrimaryKey: basicId) {
            return localObject;
        } else {
            let object = User()
            object.objectID = basicId
            realm.add(object)
            object.createBaseCurrencies(realm: realm)
            return object
        }
    }
    
    func createBaseCurrencies(realm: Realm) {
        Currency.createIfNeeded(fromCurrency, realm: realm)
        Currency.createIfNeeded(toCurrency, realm: realm)
    }
    
    func changeCurrency(_ position: Int, _ shortName: String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            
            if (position == 0) {
                fromCurrency = shortName
            } else {
                toCurrency = shortName
            }
            
            try! realm.commitWrite()
        }
    }
}

extension User {
    
    static let basicId = "000"
    
    static func getMainUser() -> User? {
        let realm = try! Realm()
        return realm.object(ofType: User.self, forPrimaryKey: basicId)
    }
}
