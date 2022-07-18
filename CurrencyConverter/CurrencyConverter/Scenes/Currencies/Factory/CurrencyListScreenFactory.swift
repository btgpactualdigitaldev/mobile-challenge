//
//  CurrencyListScreenFactory.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

struct CurrencyListScreenFactory {
    static func buildCurrencyListScreen(isInitial: Bool) -> CurrenciesViewController {
        let viewModel = CurrenciesViewModel()
        let viewController = CurrenciesViewController(viewModel: viewModel)
        viewController.isInitial = isInitial
        return viewController
    }
}
