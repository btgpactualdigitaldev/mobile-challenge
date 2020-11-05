//
//  CurrencyNameCD+CoreDataProperties.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//
//

import Foundation
import CoreData


extension CurrencyNameCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyNameCD> {
        return NSFetchRequest<CurrencyNameCD>(entityName: "CurrencyNameCD")
    }

    @NSManaged public var id: UUID
    @NSManaged public var code: String
    @NSManaged public var name: String

}

extension CurrencyNameCD {

    func toDomainModel() -> [String: String] {
        
        let currencyName = [code: name]
        
        return currencyName
    }
}
