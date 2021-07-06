//
//  ExchangeCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit



final class ExchangeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var presenter: UINavigationController
    private let exchangeViewController: ExchangeViewController
    private let exchangeViewModel: ExchangeViewModel
    private var currencyListCoordinator: CurrencyListCoordinator?

    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.exchangeViewModel = ExchangeViewModel()
        self.exchangeViewController = ExchangeViewController(viewModel: exchangeViewModel)
        self.exchangeViewController.coordinator = self

    }
    
    // MARK: - Methods
    
    func start() {
        self.presenter.pushViewController(exchangeViewController, animated: true)
    }
    
    
}

// MARK: - Exchange Delegate

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    
    func presentCurrencyListWithButtonType(_ type: CurrencyButtonType) {
        self.currencyListCoordinator = CurrencyListCoordinator(presenter: self.presenter, currencyButtonType: type)
        self.currencyListCoordinator?.currencyListCoordinatorDelegate = self
        self.currencyListCoordinator?.start()
    }
    
}

extension ExchangeCoordinator: CurrencyListCoordinatorDelegate {
    
    func navigateToExchangeViewControllerWithCurrency(_ currency: Currency, withCurrencyButtonType type: CurrencyButtonType) {
        
        switch type {
        
        case .origin:
            self.exchangeViewModel.originCurrency = currency
            self.exchangeViewController.setupOriginButton()
        case .destination:
            self.exchangeViewModel.destinationCurrency = currency
            self.exchangeViewController.setupDestinationButton()
        }
        
    }

}
