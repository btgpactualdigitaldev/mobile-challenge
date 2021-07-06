//
//  CurrencyListCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

protocol CurrencyListCoordinatorDelegate: class {
    func navigateToExchangeViewControllerWithCurrency(_ currency: Currency, withCurrencyButtonType type: CurrencyButtonType)
}

final class CurrencyListCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var presenter: UINavigationController
    private var currencyListViewController: CurrencyListViewController
    private var currencyListViewModel: CurrencyListViewModel
    weak var currencyListCoordinatorDelegate: CurrencyListCoordinatorDelegate?
    
    init(presenter: UINavigationController, currencyButtonType: CurrencyButtonType) {
        self.presenter = presenter
        self.currencyListViewModel = CurrencyListViewModel(currencyButtonType: currencyButtonType, context: CoreDataStack.shared.viewContext)
        self.currencyListViewController = CurrencyListViewController(viewModel: currencyListViewModel)
        self.currencyListViewController.coordinator = self
    }
    
    // MARK: - Methods
    
    func start() {
        self.presenter.present(currencyListViewController, animated: true)
    }
    
    
}

extension CurrencyListCoordinator: CurrencyListViewControllerDelegate {
    
    func backToExchangeViewControllerWithCurrency(_ currency: Currency, withCurrencyButtonType type: CurrencyButtonType) {
        self.presenter.dismiss(animated: true)
        self.currencyListCoordinatorDelegate?.navigateToExchangeViewControllerWithCurrency(currency, withCurrencyButtonType: type)
    }
    
    func dismissAndBackToExchangeViewController(){
        self.presenter.dismiss(animated: true)
    }
}
