//
//  Constants.swift
//  TrocaMoeda
//
//  Created by mac on 23/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import Foundation

struct K {
    struct API {
        static let currencyListURL = "http://api.currencylayer.com/list?access_key=ef61efaee08fd52dbcb6ba06a41e3511"
        static let currencyRatesURL = "http://api.currencylayer.com/live?access_key=ef61efaee08fd52dbcb6ba06a41e3511"
    }
    struct mockAPI {
        static let currencyListURL = "http://localhost:8000/list"
        static let currencyRatesURL = "http://localhost:8000/live"
    }
    static let cellIdentifier = "CurrencyBlock"
    static let cellNibName = "CurrencyCell"
}
