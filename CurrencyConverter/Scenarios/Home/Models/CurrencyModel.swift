//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RealmSwift

class CurrencyModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var nameFull = ""
    @objc dynamic var quote: Double = 0
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
