//
//  LocalCurrency+CoreDataProperties.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//
//

import Foundation
import CoreData


extension LocalCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalCurrency> {
        return NSFetchRequest<LocalCurrency>(entityName: "LocalCurrency")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var value: Double

}

extension LocalCurrency : Identifiable {

}
