//
//  Identifiable.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

protocol Identifiable {
    static var uniqueIdentifier: String { get }
}

extension Identifiable {
    static var uniqueIdentifier: String {
        String(describing: self)
    }
}

