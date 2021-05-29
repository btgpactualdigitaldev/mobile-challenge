//
//  SelectCurrencyDelegate.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

protocol SelectCurrencyDelegate: AnyObject {
    func getCurrency(currency: CurrencyModel)
}
