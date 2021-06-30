//
//  CurrencyListCoordinatorDelegate.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import Foundation

protocol CurrencyListCoordinatorDelegate: NSObject {
    func currencySelected(_ selectedCurrency: Currency, for type: CurrencyType, from coordinator: CurrencyListCoordinator)
}
