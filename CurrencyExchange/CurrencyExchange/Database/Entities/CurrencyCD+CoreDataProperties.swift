//
//  CurrencyCD+CoreDataProperties.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//
//

import Foundation
import CoreData


extension CurrencyCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyCD> {
        return NSFetchRequest<CurrencyCD>(entityName: "CurrencyCD")
    }

    @NSManaged public var code: String
    @NSManaged public var name: String
    @NSManaged public var value: Double


}

extension CurrencyCD : Identifiable {

}

extension CurrencyCD: DomainModel {
    typealias DomainModelType = Currency
    
    func toDomainModel() -> Currency {
        return Currency(name: name, code: code, value: value)
    }
}
