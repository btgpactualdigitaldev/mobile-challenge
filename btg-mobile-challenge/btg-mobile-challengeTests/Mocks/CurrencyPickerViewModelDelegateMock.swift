//
//  CurrencyPickerViewModelDelegateMock.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 04/10/20.
// swiftlint:disable all

import UIKit
@testable import btg_mobile_challenge

final class CurrencyPickerViewModelDelegateMock: NSObject, CurrencyPickerViewModelDelegate {
    var previousSelectedCurrency: IndexPath = []
    var newSelectedCurrency: IndexPath = []

    func didSelectCurrency(_ new: IndexPath, previous: IndexPath) {
        newSelectedCurrency = new
        previousSelectedCurrency = previous
    }

}
