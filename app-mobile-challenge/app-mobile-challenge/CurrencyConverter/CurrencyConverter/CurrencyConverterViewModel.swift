//
//  CurrencyConverterViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

// Class

struct CurrencyConverterViewModel {

    // Properties

    var fromCurrency: String { CommonData.shared.fromCurrencyStorage }
    var toCurrency: String { CommonData.shared.toCurrencyStorage }
    var currencyValue: String = ""
    var currencyValueIsEmpty: Bool { currencyValue == "" }

    // Private Methods

    private let coordinatorDelegate: CurrencyCoordinatorDelegate


    // Lifecycle

    init(coordinator: CurrencyCoordinatorDelegate) {
        self.coordinatorDelegate = coordinator
    }

    // Methods

    func pickSupporteds(type: PickCurrencyType) {
        ImpactFeedback.run(style: .medium)
        CommonData.shared.selectedTypeCurrency = type.rawValue
        coordinatorDelegate.showSupporteds(type: type)
    }

    func openSupporteds() {
        ImpactFeedback.run(style: .medium)
        CommonData.shared.selectedTypeCurrency = "none"
        coordinatorDelegate.showSupporteds(type: .none)
    }

    func calculateConvertion() -> (
        (
            valueFrom: String,
            valueTo: String
        )?,
        String?)
    {
        ImpactFeedback.run(style: .heavy)
        return Convertion.getCurrrency(
            from: fromCurrency,
            to: toCurrency,
            valueFrom: currencyValue
        )
    }
}
