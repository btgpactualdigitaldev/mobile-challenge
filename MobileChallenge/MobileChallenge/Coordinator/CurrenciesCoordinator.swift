//
//  CurrenciesCoordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

protocol CurrenciesViewControllerDelegate: class {
    func didSelectedCurrency(currencyCode: String)
    func returnToExchangesView()
}

final class CurrenciesCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private var currenciesViewController: CurrenciesViewController
    private var callerButtonTag: Int
    
    init(presenter: UINavigationController, callerButtonTag: Int) {
        self.presenter = presenter
        self.callerButtonTag = callerButtonTag
        
        self.currenciesViewController = CurrenciesViewController()
        self.currenciesViewController.coordinator = self
    }
    
    func start() {
        presenter.present(currenciesViewController, animated: true)
    }
}

extension CurrenciesCoordinator: CurrenciesViewControllerDelegate {
    
    func didSelectedCurrency(currencyCode: String) {
        guard let controller = presenter.topViewController as? ExchangeViewController else {
            presenter.dismiss(animated: true)
            return
        }
        
        controller.receiveCoordinatorCallBack(currencyCode: currencyCode, callerButtonTag: self.callerButtonTag)
        presenter.dismiss(animated: true)
    }
    
    func returnToExchangesView() {
        presenter.dismiss(animated: true)
    }
}
