//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

class MainCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Methods
    func start() {
        let currencyConverterViewController = CurrencyConverterViewController()
        currencyConverterViewController.coordinator = self
        navigationController.pushViewController(currencyConverterViewController, animated: true)
    }
}


// MARK: - Navigations
extension MainCoordinator {
    func navigateToCurrencyList(selectCurrencyDelegate: CurrencyListViewControllerDelegate? = nil) {
        let currencyListViewController = CurrencyListViewController(selectCurrencyDelegate: selectCurrencyDelegate)
        currencyListViewController.coordinator = self
        navigationController.pushViewController(currencyListViewController, animated: true)
    }
    
    func exitCurrentScreen() {
        navigationController.popViewController(animated: true)
    }
}
