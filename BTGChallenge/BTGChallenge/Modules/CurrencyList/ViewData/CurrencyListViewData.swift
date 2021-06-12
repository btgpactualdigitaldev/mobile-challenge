//
//  CurrencyListViewData.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation

class CurrencyListViewData {
    var currencyCode: String
    var currencyName: String
    
    init(currencyCode: String, currencyName: String) {
        self.currencyCode = currencyCode
        self.currencyName =  currencyName
    }
}
