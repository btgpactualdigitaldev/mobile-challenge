//
//  CurrencyQuotationEntity+CoreDataProperties.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//
//

import Foundation
import CoreData


extension CurrencyQuotationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyQuotationEntity> {
        return NSFetchRequest<CurrencyQuotationEntity>(entityName: "CurrencyQuotationEntity")
    }

    @NSManaged public var code: String?
    @NSManaged public var currency: String?
    @NSManaged public var quotation: Double

}

extension CurrencyQuotationEntity : Identifiable {

}
