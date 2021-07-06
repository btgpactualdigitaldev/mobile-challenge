//
//  CoreDataError.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import Foundation

enum CoreDataError: Error {
    case invalidManagedObjectType
    case cannotBeFetched
    case cannotBeDeleted

}

extension CoreDataError: ErrorDescriptable {
    var description: String {
        return "Precisa arrumar"
    }
}
