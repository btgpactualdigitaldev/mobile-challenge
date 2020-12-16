//
//  BTGError.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

enum BTGError: Error {
    case generic(String)
    case parse
    case unkown
}

extension BTGError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .generic(let message):
            return message
        default:
            return "Sorry! We are having some issues with your request. Please try again in a moment!"
        }
    }
}
