//
//  NetworkErrorConstants.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

enum BTGNetworkErrorConstants: String, Error {
    case invalidUrl = "This URL is invalid request. Please email us."
    case unableToComplete = "Unable to completed your request. Please check your internet"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case montlhyAttemptsOver = "Monthly attempts are over."
}

enum BTGCurrencyErrorConstants: String {
    case currencyEmptyTextField = "Value is empty. Please try a number. Ex: 23"
    case invalidCurrency = "Invalid user input. Please try a number. Ex: 23"
    case currenciesAreEmpty = "Please select two different currencies"
    case currenciesAreTheSame = "The Currencies are the same. Please choose two differents."
    case currencyPairNotFound = "Sorry we couldn't find your current in our database."
    case alertControllerErrorTitle = "Error Occured!"
}

enum BTGCurrencyQuotesConstants: String {
    case baseCurrencyAbbreviation = "USD"
}

enum BTGSceneDelegateConstants: String {
    case converterViewTitle = "BTG Currency Converter"
    case tabBarConverterItemTitle = "Exchange"
    case listViewTitle = "Avaliable Currency"
    case tabBarListItemTitle = "List"
}

enum SFSymbolsConstants: String {
    case globe = "globe"
    case list = "list.dash"
    case arrowUpDown = "arrow.up.arrow.down"
}

enum BTGNetworkControllerConstants: String {
    case baseUrl = "http://api.currencylayer.com/"
    case accessKeyQueryParam = "access_key"
    case livePath = "live"
    case listPath = "list"
}

enum ViewsConstants: String {
    case BTGTextField = "Ex: 149"
    case BTGConverterCardItemBaseTitle = "Base Currency"
    case BTGConverterCardItemBaseTargetTitle = "Target Currency"
    case BTGConverterResultLabelTitle = "Value"
    case BTGConverterTitleCardTitle = "BTG Converter"
    case BTGConverterTitleCardDefaultLastTimeUpdateMessage = "Last Update"
}

enum LocalCacheKeys: String {
    case liveQuoteRates = "LiveQuotesRates"
    case avaliableCurrencies = "AvaliableCurrencies"
    case timeToLiveDate = "TimeToLiveDate"
}
