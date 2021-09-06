//
//  CurrencyHomeViewController.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

import UIKit

protocol HomeActionsProtocol: AnyObject {
    func tapOriginButton()
    func tapDestinationButton()
    func valueDidChange(newValue: String)
    func presentAlert(_ alert: UIAlertController)
}

final class CurrencyHomeViewController: UIViewController {
    
    let viewModel: CurrencyViewModeling
    
    private lazy var screen: CurrencyHomeScreen = {
        let screen = CurrencyHomeScreen()
        screen.homeActions = self
        
        return screen
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .gray
        indicator.backgroundColor = .white
        indicator.startAnimating()
        
        return indicator
    }()
    
    init(viewModel: CurrencyViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrencies()
    }
    
    override func loadView() {
        view = loadingView
    }
}

// MARK: - ViewController Methods
private extension CurrencyHomeViewController {
    func getCurrencies() {
        viewModel.getCurrencies { [weak self] success, value in
            DispatchQueue.main.sync {
                self?.loadingView.stopAnimating()
                self?.view = self?.screen
                if success {
                    self?.screen.updateLabelValue(value)
                } else {
                    self?.screen.errorHandling()
                }
            }
        }
    }
}

// MARK: - HomeActions
extension CurrencyHomeViewController: HomeActionsProtocol {
    func tapOriginButton() {
        let viewController = viewModel.goToCurrencyList(currencyType: .origin,
                                                        delegate: self)
        present(viewController, animated: true)
    }
    
    func tapDestinationButton() {
        let viewController = viewModel.goToCurrencyList(currencyType: .destination,
                                                        delegate: self)
        present(viewController, animated: true)
    }
    
    func valueDidChange(newValue: String) {
        let value = viewModel.getValue(originValue: Double(newValue) ?? 1.0)
        screen.updateLabelValue(value)
    }
    
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - ChangeCurrency Delegate
extension CurrencyHomeViewController: ChangeCurrencyDelegate {
    func updateNewCurrency(title: String, type: CurrencyType) {
        let newValue = viewModel.updateCurrency(code: title, type: type)
        screen.updateButtonTitle(title, newValue: newValue, type: type)
    }
}
