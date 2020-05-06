//
//  HomeToCurrenciesCoordinator.swift
//  Screens
//
//  Created by Gustavo Amaral on 05/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class HomeToCurrenciesCoordinator: Coordinator {
    
    private weak var presentingController: HomeViewController?
    
    func present(from viewController: UIViewController) {
        guard let homeController = viewController as? HomeViewController else {
            fatalError("The source controller isn't of type '\(HomeViewController.self)'")
        }
        let currenciesController = CurrenciesViewController()
        currenciesController
            .viewModel
            .currencyPublisher
            .subscribe(homeController.viewModel.currencyPairSubscriber)
        
        presentingController = homeController
        currenciesController.coordinator = self
        currenciesController.modalPresentationStyle = .fullScreen
        homeController.present(currenciesController, animated: true, completion: nil)
    }
    
    func dismiss(from viewController: UIViewController) {
        presentingController?.dismiss(animated: true, completion: nil)
    }
}
