//
//  Errors.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

struct URLParsingError: Error {
    let description: String?
    let code: Int = 500
    
    init(description: String  = "Invalid parse to URL") {
        self.description = description
    }
}

struct DataTaskError: Error {
    let description: String?
    let code: Int = 400
    
    init(description: String  = "Error trying to deserialize data or communicating with the server") {
        self.description = description
    }
}
