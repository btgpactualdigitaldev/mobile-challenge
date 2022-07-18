//
//  CurrencyListCoordinator.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 14/07/22.
//

import Foundation
import UIKit

protocol CurrenciesViewControllerDelegate: AnyObject {
    func didSelectCurrency(currency: String, isInitial: Bool)
}

class CurrenciesCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    var currenciesViewControllerDelegate: CurrenciesViewControllerDelegate?
    
    init(navigationController: UINavigationController?) {
        childCoordinators = []
        self.navigationController = navigationController
    }

    func start() {}
    
    func start(isInitial: Bool) {
        let vc = CurrencyListScreenFactory.buildCurrencyListScreen(isInitial: isInitial)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectCurrency(currency: String, isInitial: Bool) {
        navigationController?.popViewController(animated: true)
        currenciesViewControllerDelegate?.didSelectCurrency(currency: currency, isInitial: isInitial)
    }
    
}
