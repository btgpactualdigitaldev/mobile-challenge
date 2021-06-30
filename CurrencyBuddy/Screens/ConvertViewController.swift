//
//  ViewController.swift
//  CurrencyBuddy
//
//  Created by Rodrigo Giglio on 21/12/20.
//

import UIKit

// MARK: - ConvertViewControllerDelegate
protocol ConvertViewControllerDelegate: class {
    func didChangeCurrency(_ currency: Currency, for convertionType: ConvertionType)
}

// MARK: - ConvertViewController
class ConvertViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var inputCurrencyButton: UIButton!
    @IBOutlet weak var outputCurrencyButtton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var convertActivityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Attributes
    let service = Service<CurrencyEndpoints>()
    var inputCurrency: String = Currency.defaultInputCurrencyCode
    var outputtCurrency: String = Currency.defaultOutputCurrencyCode
    var inputCurencyValue: CurrencyValue?
    var outputCurencyValue: CurrencyValue?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Targets
        inputCurrencyButton.addTarget(self, action: #selector(inputButtonAction), for: .touchUpInside)
        outputCurrencyButtton.addTarget(self, action: #selector(outputButtonAction), for: .touchUpInside)
        convertButton.addTarget(self, action: #selector(convertButttonAction), for: .touchUpInside)
        
        // MARK: - View Configuration
        configureKeyboard()
        outputLabel.adjustsFontSizeToFitWidth = true
        displaySavedCurrencies()
        hideActivityIndicator()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let currenciesViewController = segue.destination as? CurrenciesViewController,
              let convertionType = sender as? ConvertionType else { return }
        
        currenciesViewController.convertionType = convertionType
        currenciesViewController.convertionViewControllerDelegate = self
    }
    
    // MARK: - Outlet Functions
    @objc func inputButtonAction() {
        performSegue(withIdentifier: "currencies", sender: ConvertionType.input)
    }
    
    @objc func outputButtonAction() {
        performSegue(withIdentifier: "currencies", sender: ConvertionType.output)
    }
    
    @objc func convertButttonAction() {
        showActivityIndicator()
        service.request(.live) {
            (result: Result<CurrencyValueResponse,Error>) in

            switch result {

            case .failure(let error):
                print(error.localizedDescription)
                self.showErrorAlert()

            case .success(let currencyResponse):
                let currencyValues = CurrencyValue.fromDictionary(currencyResponse.quotes)
                                
                self.inputCurencyValue = currencyValues.first(where: { $0.code == "USD\(self.inputCurrency)" })
                self.outputCurencyValue = currencyValues.first(where: { $0.code == "USD\(self.outputtCurrency)" })
                
                self.displayConversion()
            }
            
            self.hideActivityIndicator()
        }
    }
    
    // MARK: - Keyboard Funcions
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureKeyboard() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(keyboardWillShow),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(keyboardWillHide),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Private Functions
    private func convert(input: Double, output: Double, amount: Double) -> Double {
        return amount * input * (1/output)
    }
    
    private func displayConversion() {
        
        guard let inputAmountText = inputTextField.text else {
            outputLabel.text = 0.formatted
            return
        }
        
        guard
            let inputAmount = Double(inputAmountText.replacingOccurrences(of:",", with:".")),
            let inputCurencyValue = inputCurencyValue?.value,
            let outputCurencyValue = outputCurencyValue?.value
        else {
            showErrorAlert()
            return
        }
                
        let convertedAmount = convert(input: inputCurencyValue, output: outputCurencyValue, amount: inputAmount)
        outputLabel.text = convertedAmount.formatted
    }
    
    private func displaySavedCurrencies() {
        
        if let inputCurrency = UserDefaultsAccess.getInputCurrencyCode() {
            self.inputCurrency = inputCurrency
            inputCurrencyButton.setTitle(inputCurrency, for: .normal)
        }
        
        if let outputCurrency = UserDefaultsAccess.getOutputCurrencyCode() {
            self.outputtCurrency = outputCurrency
            outputCurrencyButtton.setTitle(outputCurrency, for: .normal)
        }
    }
    
    func showActivityIndicator() {
        convertActivityIndicator.isHidden = false
        convertActivityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        convertActivityIndicator.isHidden = true
    }
}

// MARK: - ConvertViewControllerDelegate
extension ConvertViewController: ConvertViewControllerDelegate {
    
    func didChangeCurrency(_ currency: Currency, for convertionType: ConvertionType) {
        switch convertionType {
        
            case .input:
                inputCurrency = currency.code
                UserDefaultsAccess.saveInputCurrencyCode(currency.code)
                inputCurrencyButton.setTitle(currency.code, for: .normal)
                
            case .output:
                outputtCurrency = currency.code
                UserDefaultsAccess.saveOutputCurrencyCode(currency.code)
                outputCurrencyButtton.setTitle(currency.code, for: .normal)
        }
        
        outputLabel.text = 0.formatted
    }
}
