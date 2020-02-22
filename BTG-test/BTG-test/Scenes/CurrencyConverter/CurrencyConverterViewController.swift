//
//  CurrencyConverterViewController.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import UIKit
import Toast_Swift
import Moya

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak private var fromCurrencyButton: UIButton!
    @IBOutlet weak private var toCurrencyButton: UIButton!
    @IBOutlet weak private var convertButton: UIButton!
    @IBOutlet weak private var inputValueTextField: UITextField!
    @IBOutlet weak private var convertedValueTextField: UITextField!
    
    @IBOutlet weak private var fromButtonActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var toButtonActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var convertButtonActivityIndicator: UIActivityIndicatorView!
    
    var viewModel = CurrencyConverterViewModel(dataSource: CurrencyConverterDataSource())
    
    private var fromCurrencySelected: String?
    private var toCurrencySelected: String?
    private var fromCurrencyButtonCurrencyListViewController: CurrencyListViewController?
    private var toCurrencyButtonCurrencyListViewController: CurrencyListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeComponents()
        configureLayout()
    }
    
    private func initializeComponents() {
        viewModel.delegate = self
        inputValueTextField.delegate = self
        selectCurrency(nil, currencyOption: .from)
        selectCurrency(nil, currencyOption: .to)
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func configureLayout() {
        fromCurrencyButton.layer.cornerRadius = 8
        toCurrencyButton.layer.cornerRadius = 8
        convertButton.layer.cornerRadius = 8
    }
    
    @IBAction func fromCurrencyButton(_ sender: Any) {
        getCurrencyList(currencyOption: .from)
    }
    
    @IBAction func toCurrencyButton(_ sender: Any) {
        getCurrencyList(currencyOption: .to)
    }
    
    @IBAction func convertButton(_ sender: Any) {
        guard let from = fromCurrencySelected, !from.isEmpty else {
            showToast(message: "Por favor, escolha de qual moeda deseja converter.")
            return
        }
        
        guard let to = toCurrencySelected, !to.isEmpty else {
            showToast(message: "Por favor, escolha para qual moeda deseja converter.")
            return
        }
        
        guard
            let amountText = inputValueTextField.text,
            !amountText.isEmpty,
            let amount = Double(amountText)
            else {
                showToast(message: "Valor inválido!")
            return
        }
        
        convertButtonActivityIndicator.startAnimating()
        convertButton.isEnabled = false
        viewModel.convertCurrency(from: from, to: to, amount: amount)
    }
    
    private func selectCurrency(_ currency: String?, currencyOption: CurrencyOption) {
        switch currencyOption {
        case .from:
            fromCurrencySelected = currency
            fromCurrencyButton.setTitle(fromCurrencySelected ?? "Escolher", for: .normal)
        case .to:
            toCurrencySelected = currency
            toCurrencyButton.setTitle(toCurrencySelected ?? "Escolher", for: .normal)
        }
    }
    
    private func showToast(message: String) {
        view.hideAllToasts()
        view.makeToast(message)
    }
    
    private func getCurrencyList(currencyOption: CurrencyOption) {
        if let currencies = SharedPreference.shared.getStoredCurrencies(),
            let vc = self.goToCurrencyListViewController(list: currencies) {
            switch currencyOption {
            case .from:
                self.fromCurrencyButtonCurrencyListViewController = vc
            case .to:
                self.toCurrencyButtonCurrencyListViewController = vc
            }
        } else {
            switch currencyOption {
            case .from:
                fromButtonActivityIndicator.startAnimating()
                fromCurrencyButton.isEnabled = false
            case .to:
                toButtonActivityIndicator.startAnimating()
                toCurrencyButton.isEnabled = false
            }
            viewModel.getCurrencyList { [weak self] (list, error) in
                guard let self = self else { return }
                switch currencyOption {
                case .from:
                    self.fromButtonActivityIndicator.stopAnimating()
                    self.fromCurrencyButton.isEnabled = true
                case .to:
                    self.toButtonActivityIndicator.stopAnimating()
                    self.toCurrencyButton.isEnabled = true
                }
                if let error = error {
                    self.showToast(message: error)
                    return
                }
                
                guard let list = list else {
                    self.showToast(message: "Ocorreu um erro inesperado!")
                    return
                }
                SharedPreference.shared.store(currencies: list)
                if let vc = self.goToCurrencyListViewController(list: list) {
                    switch currencyOption {
                    case .from:
                        self.fromCurrencyButtonCurrencyListViewController = vc
                    case .to:
                        self.toCurrencyButtonCurrencyListViewController = vc
                    }
                }
            }
        }
    }
    
    private func goToCurrencyListViewController(list: [Currency]) -> CurrencyListViewController? {
        let storyboard = UIStoryboard(name: "CurrencyList", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? CurrencyListViewController else { return nil }
        vc.viewModel = .init(currencies: list)
        vc.delegate = self
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return vc
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    func successConvertCurrency(result: Double) {
        DispatchQueue.main.async {
            self.convertButtonActivityIndicator.stopAnimating()
            self.convertButton.isEnabled = true
            self.convertedValueTextField.text = "\(result)"
        }
    }
    
    func failureConvertCurrency(error: String) {
        showToast(message: error)
    }
}

extension CurrencyConverterViewController: CurrencyListViewControllerDelegate {
    func didSelectCurrency(currencyListViewController: CurrencyListViewController, currency: Currency) {
        DispatchQueue.main.async {
            if currencyListViewController == self.fromCurrencyButtonCurrencyListViewController {
                self.selectCurrency(currency.title, currencyOption: .from)
            } else {
                self.selectCurrency(currency.title, currencyOption: .to)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numericsAndDots = CharacterSet(charactersIn: "1234567890,.")
        if (string.rangeOfCharacter(from: numericsAndDots) != nil) {
            return true
        } else if !((string == "" || string == " ") && (textField.text?.count)! > 0) {
            return false
        }
        return true
    }
}

extension CurrencyConverterViewController {
    enum CurrencyOption {
        case from
        case to
    }
}
