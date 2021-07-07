//
//  MainCoordinator.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        let viewController = ExchangeViewController.instantiate(from: UIStoryboard.Name.exchangeScreen)
        let viewModel = ExchangeViewModel(service: CurrencyLayerAPI(), coreData: CoreDataManager())
        let currencyViewModel = SupportedCurrenciesViewModel(coreData: CoreDataManager())

        viewController?.coordinator = self
        viewController?.viewModel = viewModel
        viewController?.currencyViewModel = currencyViewModel
        navigationController.pushViewController(viewController!, animated: true)
    }

    // MARK: - Navigation Functions
    func goToExchangeScreen(with viewModel: ExchangeViewModel, withCurrency currencyViewModel: SupportedCurrenciesViewModel) {
        let viewController = ExchangeViewController.instantiate(from: UIStoryboard.Name.exchangeScreen)
        viewController?.coordinator = self
        viewController?.viewModel = viewModel
        viewController?.currencyViewModel = currencyViewModel
        navigationController.popViewController(animated: true)
    }

    func goToCurrenciesScreen(with viewModel: SupportedCurrenciesViewModel) {
        let viewController = SupportedCurrenciesViewController.instantiate(from: UIStoryboard.Name.currenciesScreen)

        viewController?.coordinator = self
        viewController?.viewModel = viewModel
        navigationController.pushViewController( viewController!, animated: true)
    }
}
