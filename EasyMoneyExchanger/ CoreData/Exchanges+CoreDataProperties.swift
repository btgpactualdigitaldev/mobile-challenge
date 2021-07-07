//
//  Exchanges+CoreDataProperties.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//
//

import Foundation
import CoreData

extension Exchanges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exchanges> {
        return NSFetchRequest<Exchanges>(entityName: "Exchanges")
    }

    @NSManaged public var from: String?
    @NSManaged public var to: String?
}
