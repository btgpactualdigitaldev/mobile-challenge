//
//  CurrencyChoosing.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol CurrencyChoosing: AnyObject {
    /// Creates the navigation flow to choose a currency
    /// - Parameters:
    ///   - type: currency type (origin or target currency)
    ///   - onSelect: closure to inform changes
    func chooseCurrency(type: CurrencyConverterViewModel.CurrencyType,
                        onSelect: @escaping (Currency) -> Void)
}
