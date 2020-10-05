//
//  CurrencyConverterCoordinator.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit
import os.log

/// The service responsible for managing navigation for picking and converting currencies.
protocol CurrencyConverterCoordinatorService: Coordinator {
    func pickCurrency(_ case: CurrencyPickingCase, currencies: ListCurrencyResponse)
    func showCurrencies(_ currencies: ListCurrencyResponse)
}

/// `Coordinator` responsible for managing navigation for picking and converting currencies.
final class CurrencyConverterCoordinator: CurrencyConverterCoordinatorService {

    private let networkManager: NetworkManager

    /// The `UINavigationController` responsible for this `Coordinator`.
    var navigationController: UINavigationController

    /// Initiliazes a new instance of this type.
    /// - Parameter navigationController: The `UINavigationController` responsible for this `Coordinator`.
    init(navigationController: UINavigationController,
         networkManager: NetworkManager) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }

    /// Starts this screen flow.
    func start() {
        os_log("Coordinator: showing initial screen.", log: .appflow, type: .debug)
        let viewModel = CurrencyConverterViewModel(networkManager: networkManager, coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }

    /// Navigates to currency picking screen.
    func pickCurrency(_ case: CurrencyPickingCase, currencies: ListCurrencyResponse) {
        os_log("Coordinator: showing currency picking screen.", log: .appflow, type: .debug)
        let viewModel = CurrencyPickerViewModel(currencies: currencies, coordinator: self, case: `case`)
        let viewController = CurrencyPickerViewController(viewModel: viewModel)
        let modalNavigationController = UINavigationController(rootViewController: viewController)
        modalNavigationController.navigationBar.tintColor = .systemRed
        modalNavigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]

        modalNavigationController.modalPresentationStyle = .fullScreen

        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }

    /// Navigates to supported currencies screen.
    func showCurrencies(_ currencies: ListCurrencyResponse) {
        os_log("Coordinator: showing supported currencies screen.", log: .appflow, type: .debug)
        let viewModel = SupportedCurrenciesViewModel(currencies: currencies)
        let viewController = SupportedCurrenciesViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }

}
