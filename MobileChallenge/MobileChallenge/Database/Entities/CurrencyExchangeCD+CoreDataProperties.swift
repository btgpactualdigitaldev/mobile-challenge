//
//  CurrencyExchangeCD+CoreDataProperties.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//
//

import Foundation
import CoreData


extension CurrencyExchangeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyExchangeCD> {
        return NSFetchRequest<CurrencyExchangeCD>(entityName: "CurrencyExchangeCD")
    }

    @NSManaged public var id: UUID
    @NSManaged public var code: String
    @NSManaged public var exchange: Double

}

extension CurrencyExchangeCD {

    func toDomainModel() -> [String: Double] {
        
        let currencyExchange = [code: exchange]
        
        return currencyExchange
    }
}

