//
//  Quote.swift
//  Models
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

public struct Quote: Hashable, Comparable {
    public let first: Currency
    public let second: Currency
    public let value: Double
    
    public init(_ first: Currency, _ second: Currency, _ value: Double) {
        self.first = first
        self.second = second
        self.value = value
    }
    
    public static func < (lhs: Quote, rhs: Quote) -> Bool {
        if lhs.value == rhs.value {
            if lhs.first == rhs.first {
                return lhs.second < rhs.second
            }
            return lhs.first < rhs.first
        }
        return lhs.value < rhs.value
    }
    
    public typealias Currency = String
}
