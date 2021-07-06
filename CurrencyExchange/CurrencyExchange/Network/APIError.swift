//
//  APIError.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

enum APIError: Error, ErrorDescriptable {
    
    case decode
    case invalidUrl
    case badRequest
    case requestFailed

    var description: String {
        switch self {
        
        case .decode:
            return "Error to Decode."
        case .invalidUrl:
            return "Error in url."
        case .badRequest:
            return "Bad request"
        case .requestFailed:
            return "Request failed. Please, try again later."
        }
    }

}
