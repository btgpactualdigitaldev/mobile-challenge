//
//  BTGAppCoordinator.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import Foundation
import UIKit

protocol BTGAppCoordinatorDelegate: AnyObject {
    func showPickerCurrencies()
}

class BTGAppCoordinator: Coordinator {
    
    var viewModel: BTGCurrencyConverterViewModel?
    
    private lazy var navController: UINavigationController = {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        //navController.setNavigationBarHidden(true, animated: false)
        return navController
    }()
    
    init(window: UIWindow?) {
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    
    func start() {
        let viewModel = BTGCurrencyConverterViewModel(dataSource: MockCurrencyDataSource())
        self.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        let viewController = BTGCurrencyConverterViewController(viewModel: viewModel)
        navController.pushViewController(viewController, animated: false)
    }
}

extension BTGAppCoordinator : BTGAppCoordinatorDelegate {
    func showPickerCurrencies() {
        let viewModel = BTGCurrenciesAvaliableViewModel(delegate: self)
        let viewController = BTGCurrenciesAvaliableViewController(viewModel: viewModel)
        navController.pushViewController(viewController, animated: true)
    }
}

extension BTGAppCoordinator : BTGCurrenciesAvaliableViewModelDelegate {
    func didChoiseCurrency(currency: Currency) {
        self.viewModel?.updateCurrency(currencyCode: currency.code)
        navController.popViewController(animated: true)
    }
}


