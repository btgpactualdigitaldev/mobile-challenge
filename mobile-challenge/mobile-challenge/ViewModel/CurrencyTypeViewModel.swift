//
//  CurrencyTypeViewModel.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 25/11/20.
//

import Foundation

struct CurrencyTypeViewModel {
    let currencyType: CurrencyType
    
    var acronym: String{
        return currencyType.acronym!
    }
    var currencyName: String{
        return currencyType.currencyName!
    }
    init(currencyType: CurrencyType) {
        self.currencyType = currencyType
    }
}
