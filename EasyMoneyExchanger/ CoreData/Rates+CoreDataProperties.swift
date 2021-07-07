//
//  Rates+CoreDataProperties.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//
//

import Foundation
import CoreData

extension Rates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rates> {
        return NSFetchRequest<Rates>(entityName: "Rates")
    }

    @NSManaged public var quotes: [String: Float]?
    @NSManaged public var timeStamp: Int64

}
