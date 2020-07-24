//
//  Constants.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import Foundation

enum BaseCurrency: String {
    case base = "USD"
}

enum StringFormat: String {
    case twoDecimalPlaces = "%.2f"
}

enum ButtonTitles: String {
    case selectCurrency = "Select a currency"
}

enum LabelTitles: String {
    case baseCurrency = "From"
    case targetCurrency = "To"
}

enum ViewControllerTitles: String {
    case list = "Currency List"
    case converter = "Currency Converter"
    case listSelector = "Select a currency"
}

enum TabBarItems: String {
    case list = "List"
    case converter = "Converter"
}

enum CellIds: String {
    case listView = "ListViewCell"
}

enum PlaceholderText: String {
    case textField = "Enter a value"
    case initialValue = "1.00"
    case searchBar = "Search for a currency"
}

enum AlertController: String {
    case errorTitle = "An Error has occured"
    case okButton = "OK"
    case orderTitle = "Select Display Order"
    case byName = "By name"
    case bySymbol = "By symbol"
    case cancelButton = "Cancel"
    case mustContainNumbers = "The value field may only contain numbers"
}

enum Colors: String {
    case accent = "Accent"
    case background = "Background"
    case highlight = "Highlight"
    case label = "Label"
    case main = "Main"
    case secondaryLabel = "SecondaryLabel"
}

enum UrlStubs: String {
    case base = "http://api.currencyLayer.com/"
    case list = "list?access_key="
    case live = "live?access_key="
}

enum UserDefaultsKeys: String {
    case currencies = "currencies"
    case quotes = "quotes"
}
