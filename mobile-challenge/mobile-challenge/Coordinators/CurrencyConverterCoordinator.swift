//
//  CurrencyConverterCoordinator.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import UIKit

final class CurrencyConverterCoordinator: Coordinator {
    
    let viewModel: CurrencyConverterViewModel = CurrencyConverterViewModel()
    
    override func start() {
        viewModel.coordinator = self
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}


extension CurrencyConverterCoordinator {
    
    func selectCurrencyButtonDidTap(_ currencyList: CurrencyList, for type: CurrencyType) {
        let coordinator = CurrencyListCoordinator(currencyList, for: type, navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

extension CurrencyConverterCoordinator: CurrencyListCoordinatorDelegate {
    
    func currencySelected(_ selectedCurrency: Currency, for type: CurrencyType, from coordinator: CurrencyListCoordinator) {
        
        switch type {
        case .origin:
            viewModel.setOrigin(for: selectedCurrency)
        case .destiny:
            viewModel.setDestiny(for: selectedCurrency)
        }
        
        navigationController.popViewController(animated: true)
        removeChildCoordinator(coordinator)
    }
}
