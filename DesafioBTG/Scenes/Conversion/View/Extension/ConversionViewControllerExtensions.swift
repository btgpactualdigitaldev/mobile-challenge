//
//  ConversionViewControllerExtensions.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 20/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

extension ConversionViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.sourceText == nil && self.toText == nil {
            self.showAlert(title: "Alerta", message: "Selecione a moeda de conversão e a moeda a ser convertida.")
            
            textField.becomeFirstResponder()
        }
        
        if self.sourceText == nil && self.toText != nil {
            self.showAlert(title: "Alerta", message: "Selecione a moeda de conversão.")
            
            textField.becomeFirstResponder()
        }
        
        if self.sourceText != nil && self.toText == nil {
            self.showAlert(title: "Alerta", message: "Selecione a moeda a ser convertida.")
            
            textField.becomeFirstResponder()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = self.valueTextField.text, let source = self.sourceText {
            textField.text = text.currencyInputFormatting(withCode: source)
        }
    }
    
}

extension ConversionViewController: ConversionDisplayDelegate {
    
    func displaySourceButton(sourceButtonText: String?) {
        if let text = sourceButtonText {
            self.sourceText = text
            self.setupSourceButton(sourceText: text)
            
            guard let valueText = valueTextField.text else { return }
            
            self.valueTextField.text = valueText.currencyInputFormatting(withCode: text)
        }
    }
    
    func displayToButton(toButtonText: String?) {
        if let text = toButtonText {
            self.toText = text
            self.setupToButton(toText: text)
            
            guard let valueText = valueTextField.text else { return }
            
            self.valueTextField.text = valueText.currencyInputFormatting(withCode: text)
        }
    }
    
    func displayCurrencies(viewModel: Conversion.Quotes.ViewModel) {
        self.convertedActivityIndicator.isHidden = true
        self.convertedActivityIndicator.stopAnimating()
        
        guard let text = self.toText else { return }
        
        self.convertedValueLabel.text = String(format: "%.2f", viewModel.currentQuote).currencyInputFormatting(withCode: text)
        self.convertedValueLabel.isHidden = false
    }
    
    func displayErrorInConvertCurrency() {
        self.showAlert(title: "Erro", message: "Erro ao obter a cotação atual. Por favor tente novamente mais tarde.")
    }
    
}
