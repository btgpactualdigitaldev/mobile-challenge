//
//  Sort.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import Foundation

protocol Sort {
    associatedtype Element
    static func apply(collection: [Element]) -> [Element]
}
