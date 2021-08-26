//
//  ViewController.swift
//  Desafio_BTG
//
//  Created by Kleyson on 10/12/2020.
//  Copyright © 2020 Kleyson. All rights reserved.
//

import UIKit

final class ConversionViewController: UIViewController {
    
    @IBOutlet weak var sourceCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var resultCurrencyLabel: UILabel!
    private var pickerView = UIPickerView()
    private var currencyArray: [Currencies] = [.dolar, .euro, .real]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        sourceCurrencyTextField.inputView = pickerView
        targetCurrencyTextField.inputView = pickerView
        sourceCurrencyTextField.text = currencyArray[0].rawValue
        targetCurrencyTextField.text = currencyArray[1].rawValue
    }
    
    private func calculateCurrency (_ sourceValue: Double,_ destinationValue: Double) -> Double {
        var result = 0.0
        if let qtd =  Double(self.valueTextField.text ?? "") {
            if sourceValue > destinationValue {
                result = (qtd * destinationValue)/sourceValue
            } else {
                result = (destinationValue/sourceValue) * qtd
            }
        }
        return result
    }
    
    private func formatCurrencyNumber (result: Double) -> String {
        let format = round(result * 100)/100 //arrendondar o texto
        return "$ " + String(format).replacingOccurrences(of: ".", with: ",")
    }
    
    private func getCurrencyCode(currency: Currencies) -> String {
        switch currency {
        case .dolar:
            return "USDUSD"
        case .euro:
            return "USDEUR"
        case .real:
            return "USDBRL"
        }
    }
    
    private func showErrorMessage(message: String) {
        let alertController = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        let source = Currencies(rawValue: sourceCurrencyTextField.text ?? "")
        let destination = Currencies(rawValue: targetCurrencyTextField.text ?? "")
        
        API.fetchQuotes(completion: { (quotes) in
            if let dictQuotes = quotes.quotes, let sourceValue = dictQuotes[self.getCurrencyCode(currency: source ?? .dolar)], let destinationValue = dictQuotes[self.getCurrencyCode(currency: destination ?? .dolar)] {
                let result = self.calculateCurrency(sourceValue,destinationValue)
                self.resultCurrencyLabel.text = self.formatCurrencyNumber(result: result)
                self.view.endEditing(true)
            }
        }) { (errorMessage) in
            self.showErrorMessage(message: errorMessage)
        }
    }
}

extension ConversionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if sourceCurrencyTextField.isFirstResponder{
            sourceCurrencyTextField.text = currencyArray[row].rawValue
        } else if targetCurrencyTextField.isFirstResponder{
            targetCurrencyTextField.text = currencyArray[row].rawValue
        }
    }
}
