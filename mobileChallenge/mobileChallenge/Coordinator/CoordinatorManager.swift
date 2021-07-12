//
//  CoordinatorManager.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 21/11/20.
//

import Foundation
import UIKit

/// Class CoordinatorManager
class CoordinatorManager: Coordinator{
    
    //MARK: - Variables
    /// Variables
    var navigationController: UINavigationController
    
    
    //MARK: - Initializer
    /// Init
    /// - Parameter navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Functions
    /// Start Coordinator
    func start() {
        let currencyVC = CurrencyViewController()
        currencyVC.coordinator = self
        navigationController.pushViewController(currencyVC, animated: true)
    }
}

extension CoordinatorManager {
    func navigateToTableCurrencyVC(receiver: CurrencyViewModelReceiver, delegateTableViewCurrency: CurrencyViewController) {
        let tableCurrencyVC = TableCurrencyViewController()
        tableCurrencyVC.coordinator = self
        tableCurrencyVC.coordinator = self
        tableCurrencyVC.dataDelegate = delegateTableViewCurrency
        tableCurrencyVC.currencyViewModel.receptorData = receiver
        navigationController.pushViewController(tableCurrencyVC, animated: true)
    }
}
