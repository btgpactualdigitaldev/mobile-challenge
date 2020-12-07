//
//  CurrencyCoordinator.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit
import Combine

protocol ConverterCoordinatorProtocol: AnyCoordinator {
    func showCurrencies(type: CurrenciesViewModel.ActionType)
    func back()
}

final class ConverterCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.fetchData()
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            self.fetchLives()
            self.fetchList()
        }
    }
    
    func start() {
        let currencies = UserDefaults.LCurrency.currencies
        let viewModel = ConverterViewModel(coordinator: self)
        let viewController = ConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func fetchLives() {
        let interactor = CurrencyInteractor(didFail: { (error) in
            
        }, didReceiveCurrencies: { (data) in
            if let data = data as? [String: Double] {
                let lives = Live.getLiveCurrency(lives: data)
                UserDefaults.LCurrency.lives = lives
            }
        })
        
        interactor.fetchLives()
    }
    
    private func fetchList() {
        let interactor = CurrencyInteractor(didFail: { (error) in
            
        }, didReceiveCurrencies: { (data) in
            if let data = data as? [String: String] {
                let currencies = Currency.getListCurrency(currencies: data)
                UserDefaults.LCurrency.currencies = currencies
            }
        })
        
        interactor.fetchList()
    }
}

extension ConverterCoordinator: ConverterCoordinatorProtocol {
    func showCurrencies(type: CurrenciesViewModel.ActionType) {
        let currencies = UserDefaults.LCurrency.currencies
        let viewModel = CurrenciesViewModel(coordinator: self, currencies: currencies, type: type)
        
        let viewController = CurrenciesViewController(viewModel: viewModel)
        let navigationModelController = UINavigationController(rootViewController: viewController)
        navigationModelController.navigationBar.tintColor = .black
        navigationModelController.modalPresentationStyle = .fullScreen
        
        navigationController.present(navigationModelController, animated: true)
    }
    
    func back() {
        navigationController.dismiss(animated: true)
    }
}
