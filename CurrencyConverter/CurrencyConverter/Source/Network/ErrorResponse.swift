//
//  ErrorResponse.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

struct ErrorResponse: Error, Decodable {
    let success: Bool
    let error: ErrorDetail
}

struct ErrorDetail: Decodable {
    let code: Int
    let info: String
}
