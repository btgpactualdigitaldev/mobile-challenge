//
//  CoinError.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import Foundation

enum CoinError: String, Error {
    case invalidAccess      = "This access key create an invalid request. Please verify your key."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid request from the server. Please try again."
    case invallidData       = "The data receiced from the server was invalid. Please try again."
}
