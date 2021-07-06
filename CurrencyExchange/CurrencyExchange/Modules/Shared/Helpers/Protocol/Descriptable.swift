//
//  ErrorDescriptable.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

protocol Descriptable {
    var description: String { get }
}

protocol ErrorDescriptable: Descriptable {}
