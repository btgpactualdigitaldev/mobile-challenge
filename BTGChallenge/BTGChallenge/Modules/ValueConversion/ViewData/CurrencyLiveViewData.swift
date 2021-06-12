//
//  CurrencyLiveViewData.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 15/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class CurrencyLiveViewData {
    var currencyCode: String
    var CurrencyQuote: Double
    
    init(currencyCode: String, currencyQuote: Double) {
        self.currencyCode = currencyCode
        self.CurrencyQuote =  currencyQuote
    }
}
