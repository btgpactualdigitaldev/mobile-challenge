//
//  MainRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainRouter: GenericRouter {

    // MARK: - Attributes
    private var viewModel: MainViewModel
    
    // MARK: - Overrides
    override init(navigationController: UINavigationController) {
        self.viewModel = MainViewModel(currencyRepository: CurrencyRepository(network: Network()))
        super.init(navigationController: navigationController)
        self.viewModel.router = self
    }

    // MARK: - Public Methods
    func present() {
        self.navigationController.pushViewController(MainViewController(mainViewModel: self.viewModel), animated: true)
    }

    func presentCurrencysView(order: CurrenciesPosition, selectedCurrency: @escaping (Currency) -> Void) {
        CurrencysRouter(navigationController: self.navigationController).present(order: order, selectedCurrency: selectedCurrency)
    }
}
