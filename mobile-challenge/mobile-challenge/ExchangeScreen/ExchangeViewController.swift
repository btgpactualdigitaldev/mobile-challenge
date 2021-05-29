//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    private let exchangeView = ExchangeView()
    private var buttonPressed: ButtonType?
    private let exchangeViewModel = ExchangeViewModel()
    private let alert = UIAlertController(title: "Erro", message: nil, preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(exchangeView)
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupAction()
        setupClosures()
    }
    
    private func setupClosures() {
        let showCurrencyVC: (ButtonType?) -> Void = { [weak self] buttonType in
            self?.buttonPressed = buttonType
            let currencyListVC = CurrencyListViewController()
            currencyListVC.selectDelegate = self
            self?.navigationController?.pushViewController(currencyListVC, animated: true)
        }
        
        exchangeView.fromStackView.selectCurrency = showCurrencyVC
        exchangeView.toStackView.selectCurrency = showCurrencyVC
        
        exchangeView.fromStackView.convertCurrency = { [weak self] value in
            DispatchQueue.main.async {
                var result: String?
               
                do {
                    result = try self?.exchangeViewModel.convertCurrencies(value: value)
                } catch let error as ExchangeError {
                    guard let alert = self?.alert  else { return }
                    alert.message = error.errorDescription
                    self?.present(alert, animated: true, completion: nil)
                } catch {
                    guard let alert = self?.alert  else { return }
                    alert.message = "Ocorreu um erro."
                    self?.present(alert, animated: true, completion: nil)
                }
               
                self?.exchangeView.timeStampLabel.text = "Cotação do dia \(TimeStampFormatter.timeStamp)"
                self?.exchangeView.toStackView.valueTextField.text = result
            }
        }
    }

    private func setupAction() {
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            exchangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exchangeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            exchangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            exchangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ExchangeViewController: SelectCurrencyDelegate {
    func getCurrency(currency: CurrencyModel) {
        switch buttonPressed {
        case .from:
            exchangeView.fromStackView.currencyButton.setTitle(currency.name, for: .normal)
            exchangeViewModel.fromCurrency = currency
        case .to:
            exchangeView.toStackView.currencyButton.setTitle(currency.name, for: .normal)
            exchangeViewModel.toCurrency = currency
        case .none:
            buttonPressed = nil
        }
    }
}
