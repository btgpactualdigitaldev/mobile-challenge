//
//  MainCoordinator.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import UIKit

class MainCoordinator {
    
    enum ButtonType {
        case origin
        case destiny
    }

    var currencyListViewController: CurrencyListViewController
    var conversionsViewController: ConversionsViewController
    
    private var buttonType: ButtonType?
    
    init() {
        let currencyListViewModel = CurrencyListViewModel()
        self.currencyListViewController = CurrencyListViewController(viewModel: currencyListViewModel)
        currencyListViewModel.viewController = currencyListViewController
        
        let conversionsViewModel = ConversionsViewModel()
        self.conversionsViewController = ConversionsViewController(viewModel: conversionsViewModel)
        conversionsViewModel.viewController = conversionsViewController
        
        currencyListViewModel.coordinator = self
        conversionsViewModel.coordinator = self
    }
    
    func chooseOriringCurrency() {
        conversionsViewController.present(currencyListViewController, animated: true)
        buttonType = .origin
    }
    
    func chooseDestinyCurrency() {
        conversionsViewController.present(currencyListViewController, animated: true)
        buttonType = .destiny
    }
    
    func selectCurrency(currency: Currency) {
        switch buttonType {
        case .origin:
            conversionsViewController.viewModel.originCurrency.value = currency
            conversionsViewController.dismiss(animated: true, completion: nil)
        case .destiny:
            conversionsViewController.viewModel.destinyCurrency.value = currency
            conversionsViewController.dismiss(animated: true, completion: nil)
        default:
            Debugger.warning("buttonType found nil")
        }
    }
    
    func showConnectionProblemAlert(error: NetworkingError, sender: UIViewController, handler: (() -> Void)?) {
        let alertController = UIAlertController(title: error.rawValue, message: "Please check your internet connection and try again", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            handler?()
        }))
        DispatchQueue.main.async {
            sender.present(alertController, animated: true, completion: nil)
        }
    }
}
