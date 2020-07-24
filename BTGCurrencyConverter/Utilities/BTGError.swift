//
//  BTGError.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

enum BTGNetworkError: String, Error {
    case invalidURL = "An invalid request was created. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}

enum BTGConversionError: String, Error {
    case unableToConvert = "Unable to perform the conversion at this time"
    case baseCurrencyInvalid = "The base currency supplied is invalid"
    case targetCurrencyInvalid = "The target currency supplied is invalid"
    case amountBlank = "The amount entered cannot be blank"
    case amountNotNumber = "The amount must be a number"
}

enum BTGTableViewError: String, Error {
    case errorBTGListViewCell = "Unable to deque BTG List View Cell for tableview"
}

enum BTGPersistenceError: String, Error {
    case unableToSaveCurrencies = "Unable to save currencies to User Defaults"
    case unableToSaveQuotes = "Unable to save quotes to User Defaults"
}
