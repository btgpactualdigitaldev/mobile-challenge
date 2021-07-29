//
//  CurrencysRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencysRouter: GenericRouter {

    // MARK: - Attributes
    private let viewModel: CurrencysViewModel

    // MARK: - Overrides
    override init(navigationController: UINavigationController) {
        self.viewModel = CurrencysViewModel(currencyRepository: CurrencyRepository(network: Network()))
        super.init(navigationController: navigationController)
        self.viewModel.router = self
    }

    // MARK: - Public Methods
    func present(order: CurrenciesPosition, selectedCurrency: @escaping (Currency) -> Void) {
        let viewController = CurrencysViewController(currencysViewModel: self.viewModel)
        viewController.title = (order == .first) ? StringsDictionary.firstCurrency : StringsDictionary.secondCurrency
        viewController.setDelegate(selectedCurrency: selectedCurrency)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
