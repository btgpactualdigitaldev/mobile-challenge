//
//  NameSort.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import Foundation

public struct NameSort: Sort {
    typealias Element = ListItem
    
    static func apply(collection: [ListItem]) -> [ListItem] {
        collection.sorted {
            $0.countryName < $1.countryName
        }
    }
}
