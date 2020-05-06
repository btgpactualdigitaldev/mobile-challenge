//
//  Currency.swift
//  Models
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

public struct Currency: Hashable, Comparable {
    public let abbreviation: String
    public let fullName: String
    
    public init(abbreviation: String, fullName: String) {
        self.abbreviation = abbreviation
        self.fullName = fullName
    }
    
    public static func < (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.fullName < rhs.fullName
    }
}
