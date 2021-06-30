//
//  AppCoordinator.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    override func start() {
        showCurrencyConverter()
    }
}

extension AppCoordinator {
    func showCurrencyConverter() {
        let coordinator = CurrencyConverterCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
