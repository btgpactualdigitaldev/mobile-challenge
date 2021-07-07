//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = CurrencyConverterView()
    private lazy var viewModel = CurrencyConverterViewModel()
    
    weak var coordinator: MainCoordinator?
    
    private var currentCurrencyTypeButtonClicked: CurrencyTypeButtonTag?
    
    private var alertManager = AlertManager()
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupButtons()
        setupTextFields()
    }
}


// MARK: - Setup Navigation Bar
extension CurrencyConverterViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Currency Converter"
    }
}


// MARK: - Setup Buttons
extension CurrencyConverterViewController {
    private func setupButtons() {
        baseView.sourceCurrencyTypeButton.addTarget(self, action: #selector(currencyTypeDidTouch(_:)), for: .touchUpInside)
        baseView.targetCurrencyTypeButton.addTarget(self, action: #selector(currencyTypeDidTouch(_:)), for: .touchUpInside)
        baseView.conversionButton.addTarget(self, action: #selector(convertCurrenciesButtonDidTouch), for: .touchUpInside)
    }
    
    private func setupTextFields() {
        baseView.sourceCurrencyValueTextField.addTarget(self, action: #selector(sourceCurrencyTextFieldDidChange(_:)), for: .editingChanged)
        baseView.sourceCurrencyValueTextField.becomeFirstResponder()
    }
}


// MARK: - Actions
extension CurrencyConverterViewController {
    @objc private func currencyTypeDidTouch(_ sender: UIButton) {
        // Identify type button
        if sender.tag == CurrencyTypeButtonTag.sourceCurrency.rawValue {
            self.currentCurrencyTypeButtonClicked = .sourceCurrency
        } else {
            self.currentCurrencyTypeButtonClicked = .targetCurrency
        }
        
        coordinator?.navigateToCurrencyList(selectCurrencyDelegate: self)
    }
    
    @objc private func sourceCurrencyTextFieldDidChange(_ textField: UITextField) {
        // Checando se algo foi digitado
        guard let typedText = textField.text, !typedText.isEmpty else {
            viewModel.insertValueToConvert(value: 0)
            return
        }
        
        // Checando se é um número
        guard let typedValue = Double(typedText) else {
            let alert = alertManager.createGenericAlert(title: "Número inválido", message: "Digite apenas números")
            present(alert, animated: true, completion: nil)
            return
        }
        
        viewModel.insertValueToConvert(value: typedValue)
    }

    @objc private func convertCurrenciesButtonDidTouch() {
        do {
            let resultOfConversion = try viewModel.convertCurrencies()
            let textToDisplay = String(format: "%.02f", resultOfConversion)
            baseView.targetCurrencyValueTextField.text = textToDisplay
        } catch {
            let alert = alertManager.createGenericAlert(title: "Atenção", message: error.localizedDescription)
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - CurrencyListViewControllerDelegate
extension CurrencyConverterViewController: CurrencyListViewControllerDelegate {
    func didSelectCurrency(selectedCurrency: Currency) {
        guard let lastCurrencyTypeButtonClicked = currentCurrencyTypeButtonClicked else {
            return
        }

        switch lastCurrencyTypeButtonClicked {
        case .sourceCurrency:
            viewModel.insertSourceCurrency(currency: selectedCurrency)
            baseView.sourceCurrencyTypeButton.setTitle(selectedCurrency.code, for: .normal)
        case .targetCurrency:
            viewModel.insertTargetCurrency(currency: selectedCurrency)
            baseView.targetCurrencyTypeButton.setTitle(selectedCurrency.code, for: .normal)
        }
        
        self.currentCurrencyTypeButtonClicked = nil
    }
}
