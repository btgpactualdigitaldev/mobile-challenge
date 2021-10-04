//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var homeViewModel: OriginSelected?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        self.homeViewModel = viewModel
        let controller = HomeController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func openList(origin: Origin) {
        let controller = CurrencyListController(origin: origin, delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
}

extension MainCoordinator: CurrencyListDelegate {
    func didSelectCurrency(_ currency: String, origin: Origin, currencyCode: String) {
        self.homeViewModel?.onOriginSelected(origin: origin, title: currency, currencyCode: currencyCode)
        navigationController.popViewController(animated: true)
    }

}
