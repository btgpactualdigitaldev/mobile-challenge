//
//  CurrencyConverterCoordinatorServiceMock.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 04/10/20.
//
// swiftlint:disable all

import UIKit
@testable import btg_mobile_challenge

final class CurrencyConverterCoordinatorServiceMock: CurrencyConverterCoordinatorService {
    var didStart: Bool = false
    var didPickCurrency: Bool = false
    var didShowCurrency = false

    var navigationController: UINavigationController

    func pickCurrency(_ case: CurrencyPickingCase, currencies: ListCurrencyResponse) {
        didPickCurrency = true
    }

    func showCurrencies(_ currencies: ListCurrencyResponse) {
        didShowCurrency = true
    }

    func start() {
        didStart = true
    }

    init(navigationController: UINavigationController = UINavigationController(nibName: nil, bundle: nil)) {
        self.navigationController = navigationController
    }


}
