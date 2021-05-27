//
//  CurrenciesCoordinator.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 11/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import Swinject
import UIKit

protocol CurrenciesCoordinatorDelegate: AnyObject {
    func currenciesCoordinatorDidFinish()
}

final class CurrenciesCoordinator: NavigationCoordinator {
    
    // MARK: - Properties

    let navigationController: UINavigationController
    let container: Container
    weak var delegate: CurrenciesCoordinatorDelegate?

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator core

    func start() {
        showCurrencies()
    }
    
    private func showCurrencies() {
        let vc = container.resolve(CurrenciesViewController.self)!
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showConvert(fromCurrency: CurrencyModel, toCurrency: CurrencyModel) {
        let vc = container.resolve(ConvertViewController.self)!
        vc.delegate = self
        vc.viewModel.fromCurrency.accept(fromCurrency)
        vc.viewModel.toCurrency.accept(toCurrency)
        vc.viewModel.fromText.accept(fromCurrency.name)
        vc.viewModel.toText.accept(toCurrency.name)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension CurrenciesCoordinator: CurrenciesViewControllerDelegate {
    func userDidRequestConvert(fromCurrency: CurrencyModel, toCurrency: CurrencyModel) {
        showConvert(fromCurrency: fromCurrency, toCurrency: toCurrency)
    }
    
    //TODO - Novos fluxos
    func userDidRequestNewFlow() {
        delegate?.currenciesCoordinatorDidFinish()
    }
}

extension CurrenciesCoordinator: ConvertViewControllerDelegate {
    //TODO - Fluxo a partir da tela de conversão
}
