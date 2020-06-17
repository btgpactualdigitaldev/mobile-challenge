//
//  ViewController.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 16/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    @IBOutlet var originCurrencyButton: UIButton!
    @IBOutlet var destinyCurrencyButton: UIButton!
    
    @IBOutlet var destinyValueTextField: UITextField!
    @IBOutlet var originValueTextField: UITextField!
    
    var originCurreny: Currency?
    var destinyCurrency: Currency?
    
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "BTGPactual Test"
        
        loadCurrencies()
    }
    
    func loadCurrencies() {
        
        activityView.startAnimating()
        CurrencyConverter.manager.loadCurrencies(completion: {
            self.loadQuotes()
            
        }) { (errorMessage) in
            self.showAlert(message: errorMessage, handler: { _ in
                self.loadCurrencies()
            })
        }
    }
    
    func loadQuotes() {
        CurrencyConverter.manager.loadQuotes(completion: {
            self.activityView.stopAnimating()
            self.activityView.isHidden = true
            
        }) { (errorMessage) in
            self.showAlert(message: errorMessage, handler: { _ in
                self.loadQuotes()
            })
        }
    }
    
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if handler != nil {
            alert.addAction(UIAlertAction(title: "Tentar Novamente", style: .default, handler: handler))
        }
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? CurrencyTableViewController
        
        
        if (sender as? UIButton) == originCurrencyButton {
            viewController?.selectedCurrency = originCurreny
            viewController?.selectCallback = { currency in
                self.originCurreny = currency
                self.originCurrencyButton.setTitle(currency.code, for: .normal)
            }
            
        } else {
            viewController?.selectedCurrency = destinyCurrency
            viewController?.selectCallback = { currency in
                self.destinyCurrency = currency
                self.destinyCurrencyButton.setTitle(currency.code, for: .normal)
            }
        }
    }
    
    
}

extension ConverterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard self.originCurreny != nil && self.destinyCurrency != nil else {
            showAlert(message: "Selecione ambas as moedas.", handler: nil)
            textField.resignFirstResponder()
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.isEmpty {
                self.destinyValueTextField.text = ""
                
            } else if let floatValue = Float(updatedText) {
                if let convertedValue = CurrencyConverter.manager.convert(value: floatValue, from: self.originCurreny!, to: self.destinyCurrency!) {
                    self.destinyValueTextField.text = String(format: "%.2f", convertedValue)
                    
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        
        return true
    }
}

