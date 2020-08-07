//
//  Currency.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import RealmSwift

class Currency: Object {
    @objc dynamic var abbreviation = ""
    @objc dynamic var name = ""
    @objc dynamic var usdQuote = 0.0
    
    override class func primaryKey() -> String? {
        return "abbreviation"
    }
}
