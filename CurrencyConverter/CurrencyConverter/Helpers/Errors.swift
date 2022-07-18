//
//  Error.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

enum ServiceError: Error {
    case parseError
    case networkError(String)
    case badURL
    case emptyData
}
