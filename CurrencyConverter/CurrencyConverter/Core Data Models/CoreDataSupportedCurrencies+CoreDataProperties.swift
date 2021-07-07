//
//  CoreDataSupportedCurrencies+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 14/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
//

import Foundation
import CoreData

extension CoreDataSupportedCurrencies {
    @nonobjc public class func supportedCurrenciesFetchRequest() -> NSFetchRequest<CoreDataSupportedCurrencies> {
        return NSFetchRequest<CoreDataSupportedCurrencies>(entityName: "CoreDataSupportedCurrencies")
    }

    @NSManaged public var currencies: NSObject?
}
