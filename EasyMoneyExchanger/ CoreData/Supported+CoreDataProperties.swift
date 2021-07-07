//
//  Supported+CoreDataProperties.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//
//

import Foundation
import CoreData

extension Supported {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Supported> {
        return NSFetchRequest<Supported>(entityName: "Supported")
    }

    @NSManaged public var currencies: [String: String]?

}
