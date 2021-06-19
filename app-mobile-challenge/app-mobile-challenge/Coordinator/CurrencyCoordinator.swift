//
//  CurrencyConverterCoodinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import Combine

// Protocols

protocol CurrencyCoordinatorDelegate: Coordinator {
    func showSupporteds(type: PickCurrencyType)
    func backTapped()
}

// Class

final class CurrencyCoordinator: CurrencyCoordinatorDelegate {

    // Properties

    var navigationController: UINavigationController

    // Lifecycle

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Router

    func start() {
        let viewModel = CurrencyConverterViewModel(coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showSupporteds(type: PickCurrencyType) {
        let viewModel = SupportedCurrenciesViewModel(coordinator: self)
        let viewController = SupportedCurrenciesViewController(viewModel: viewModel, type: type)
        navigationController.pushViewController(viewController, animated: true)
    }

    func backTapped() {
        navigationController.popViewController(animated: true)
    }
}
