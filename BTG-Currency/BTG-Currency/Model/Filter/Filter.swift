//
//  Filter.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 29/10/21.
//

import Foundation

public struct Filter {
    static func apply(_ collection: [ListItem], arg: String) -> [ListItem] {
        let predicate = NSPredicate(format: "SELF CONTAINS %@", arg)
        return collection.filter { item in
            predicate.evaluate(with: item.code) || predicate.evaluate(with: item.countryName)
        }
    }
}
