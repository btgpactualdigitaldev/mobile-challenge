//
//  QuotationCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewModel: QuotationViewModel
    var childCoordinators: [Coordinator] = []
    weak var currencyList: CurrenciesQuotationDelegate?
    var viewController: QuotationViewController?
    
    init(navigationController: UINavigationController, manager: NetworkManager) {
        self.navigationController = navigationController
        self.viewModel = QuotationViewModel()
    }
    
    func start() {
        let controller = QuotationViewController(viewModel: viewModel)
        controller.coordinator = self
        viewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showCurrencyList(){
        let coordinator = CurrencyListCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
        currencyList = (coordinator).delegate
    }
}

extension QuotationCoordinator: SelectCurrencyQuotationDelegate {
    func didSelectCurrrencyQuotation(as tagButton: TagButton, currencyQuotation: CurrencyQuotation) {
        viewController?.updateUI(currencyQuotation: currencyQuotation, tagButton: tagButton)
    }
}
