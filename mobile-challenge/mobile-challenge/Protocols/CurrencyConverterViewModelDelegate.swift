//
//  CurrencyConverterViewModelDelegate.swift
//  mobile-challenge
//
//  Created by gabriel on 01/12/20.
//

import Foundation

protocol CurrencyConverterViewModelDelegate: NSObject {
    func dataFetched()
    func originChanged()
    func destinyChanged()
    func createAlert(title: String, message: String, handler: (() -> Void)?)
}
