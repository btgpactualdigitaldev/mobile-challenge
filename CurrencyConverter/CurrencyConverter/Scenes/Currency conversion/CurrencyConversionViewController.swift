//
//  CurrencyConversionViewController.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright (c) 2020 Tiago Chaves. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CurrencyConversionDisplayLogic: class {
    func displayErrorMessage(_ message:String)
    func exchangeRatesLoaded()
    func supportedCurrenciesLoaded()
    func displayFormattedValue(viewModel: CurrencyConversion.FormatTextField.ViewModel)
}

class CurrencyConversionViewController: UIViewController, CurrencyConversionDisplayLogic {
    var interactor: CurrencyConversionBusinessLogic?
    var router: (NSObjectProtocol & CurrencyConversionRoutingLogic & CurrencyConversionDataPassing)?
    
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVipCycle()
    }
    
    // MARK: - Setup
    private func setupVipCycle() {
        let viewController = self
        let interactor = CurrencyConversionInteractor()
        let presenter = CurrencyConversionPresenter()
        let router = CurrencyConversionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVipCycle()
        setupTextFields(textFields: [sourceValueTextField])
        getSupportedCurrencies()
        getExchangeRates()
    }
    
    var sourceCurrency: Currency = Currency(initials: "USD", name: "United States Dollar") {
        didSet {
            self.sourceCurrencyButton.setTitle("\(sourceCurrency.name) (\(sourceCurrency.initials))", for: .normal)
            formatSourceValue(sourceValueTextField.text ?? "", withNewString: " ")
        }
    }
    var resultCurrency: Currency = Currency(initials: "BRL", name: "Brazilian Real") {
        didSet {
            self.resultCurrencyButton.setTitle("\(resultCurrency.name) (\(resultCurrency.initials))", for: .normal)
            convertCurrency()
        }
    }
    
    @IBOutlet weak var sourceValueTextField: UITextField!
    @IBOutlet weak var resultValueTextField: UITextField!
    @IBOutlet weak var sourceCurrencyButton: UIButton!
    @IBOutlet weak var resultCurrencyButton: UIButton!
    
    @IBAction func showSupportedCurrencies(_ sender: UIButton) {
        let currencyType: CurrencyType = sender.tag == 0 ? .source : .result
        interactor?.identifyCurrency(currencyType)
        self.performSegue(withIdentifier: "SupportedCurrencies", sender: nil)
    }
    
    @IBAction func refreshDataFromServer(_ sender: Any) {
        getSupportedCurrencies()
        getExchangeRates()
    }
    
    //MARK: - App data setup
    private func getSupportedCurrencies() {
        interactor?.getSupportedCurrencies()
    }
    
    private func getExchangeRates() {
        interactor?.getExchangeRates()
    }
    
    //MARK: - Exchange Rates Loaded
    func exchangeRatesLoaded() {
        DispatchQueue.main.sync {
            sourceValueTextField.isEnabled = true
        }
    }
    
    //MARK: - Supported Currencies Loaded
    func supportedCurrenciesLoaded() {
        DispatchQueue.main.sync {
            sourceCurrencyButton.isEnabled = true
            resultCurrencyButton.isEnabled = true
        }
    }
    
    //MARK: - Error handle
    func displayErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        
        DispatchQueue.main.sync {
            present(alert, animated: true)
        }
    }
    
    //MARK: - Show Formatted Value
    func displayFormattedValue(viewModel: CurrencyConversion.FormatTextField.ViewModel) {
        if viewModel.textField == .source {
            self.sourceValueTextField.text = viewModel.formattedText
            convertCurrency()
        } else if viewModel.textField == .result {
            self.resultValueTextField.text = viewModel.formattedText
        }
    }
    
    private func convertCurrency() {
        guard let sourceValue = self.sourceValueTextField.text else { return }
        interactor?.convertCurrency(request: CurrencyConversion.ConvertValue.Request(sourceInitials: sourceCurrency.initials,
                                                                                     sourceValue: sourceValue,
                                                                                     resultInitials: resultCurrency.initials,
                                                                                     textField: .result))
    }
    
    private func formatSourceValue(_ sourceValue: String, withNewString newString: String) {
        let request = CurrencyConversion.FormatTextField.Request(textFieldValue: sourceValue,
                                                                 newText: newString,
                                                                 currencyInitials: sourceCurrency.initials,
                                                                 textField: .source)
        interactor?.convertStringValueInNumber(request: request)
    }
}

//MARK: - Text field delegate
extension CurrencyConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        formatSourceValue(textField.text ?? "", withNewString: string)
        return false
    }
}


//MARK: - Select Currency Delegate
extension CurrencyConversionViewController: SelectCurrencyDelegate {
    func setCurrency(_ currency: Currency, to: CurrencyType) {
        switch to {
        case .source:
            sourceCurrency = currency
        case .result:
            resultCurrency = currency
        }
    }
}

enum CurrencyType {
    case source
    case result
}
