//
//  AppCoordinator.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import Swinject
import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    private let window: UIWindow
    let container: Container
    private let navigationController: UINavigationController
    
    // MARK: - Coordinator core

    init(window: UIWindow, container: Container) {
       self.window = window
       self.container = container
       navigationController = UINavigationController()

       navigationController.navigationBar.prefersLargeTitles = true
       navigationController.view.backgroundColor = UIColor.white

       self.window.rootViewController = navigationController
    }
    
    func start() {        
        showCurrencies()
    }
    
    private func showCurrencies() {
        let currenciesCoordinator = CurrenciesCoordinator(container: container, navigationController: navigationController)
        currenciesCoordinator.delegate = self
        currenciesCoordinator.start()
    }
}

// MARK: - Delegate

extension AppCoordinator: CurrenciesCoordinatorDelegate {
    func currenciesCoordinatorDidFinish() {
        //TODO - Novos fluxos
    }
}
