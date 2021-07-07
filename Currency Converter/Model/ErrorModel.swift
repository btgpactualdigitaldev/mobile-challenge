//
//  ErrorModel.swift
//  Currency Converter
//
//  Created by Otávio Souza on 01/10/20.
//

import UIKit

class ErrorModel: Codable {
    let success : Bool
    let error : CustomError
    
    init() {
        success = false
        error = CustomError()
    }
    
    private enum CodingKeys: String, CodingKey {
        case success = "success"
        case error = "error"
    }
}

class CustomError: Codable,Error {
    let code : Int
    let info : String
    
    init() {
        code = 0
        info = ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case info = "info"
    }
}

