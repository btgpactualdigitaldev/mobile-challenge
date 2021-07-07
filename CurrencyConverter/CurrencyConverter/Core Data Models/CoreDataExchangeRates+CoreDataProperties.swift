//
//  CoreDataExchangeRates+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
//

import Foundation
import CoreData

extension CoreDataExchangeRates {
    @nonobjc public class func exchangeRatesFetchRequest() -> NSFetchRequest<CoreDataExchangeRates> {
        return NSFetchRequest<CoreDataExchangeRates>(entityName: "CoreDataExchangeRates")
    }

    @NSManaged public var quotes: NSObject?
    @NSManaged public var source: String?
}
