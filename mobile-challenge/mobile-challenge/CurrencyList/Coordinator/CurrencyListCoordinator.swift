//
//  CurrencyListCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var delegate : CurrenciesQuotationDelegate?
    weak var parentCoordinator: SelectCurrencyQuotationDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = CurrencyListViewController()
        controller.coordinator = self
        delegate = controller
        navigationController.pushViewController(controller, animated: true)
    }
    
    func didFinish(currencyQuotation: CurrencyQuotation, tagButton: TagButton) {
        parentCoordinator?.didSelectCurrrencyQuotation(as: tagButton, currencyQuotation: currencyQuotation)
        parentCoordinator?.childCoordinators.removeAll()
        navigationController.popViewController(animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll()
        navigationController.popViewController(animated: true)
    }
}
