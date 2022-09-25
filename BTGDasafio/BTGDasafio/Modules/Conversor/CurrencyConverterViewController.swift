//
//  CurrencyConverterViewController.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 28/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import UIKit

enum ConvertType {
    case from
    case to
}

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak var currencyFrom: UITextField!
    @IBOutlet weak var currencyTo: UITextField!
    @IBOutlet weak var fromButtom: CustomButton!
    @IBOutlet weak var toButton: CustomButton!
    var viewModel = CurrencyConverterViewModel(hasError: false)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureTextField()
        configureViewModel()
    }
    
    private func updateButton() {
        fromButtom.setTitle(viewModel.fromCurrencyTitle, for: .normal)
        toButton.setTitle(viewModel.toCurrencyTitle, for: .normal)
        if viewModel.hasError {
            showAlert(viewModel.alertTitle, viewModel.alertMessage)
        }
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.searchForCurrentQuote()
    }
    
    private func configureTextField() {
        currencyFrom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func updateConvertValue() {
        currencyTo.text = viewModel.convertedCurrancy
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        currencyFrom.text = textField.text?.currencyInputFormatting()
        viewModel.convertCurrency(value: textField.text)
    }
    
    private func segue(buttonType: ConvertType) {
        viewModel.setSelectedButton(selected: buttonType)
        if let vc = storyboard?.instantiateViewController(withIdentifier: viewModel.vcIdentifier) as? ListQuotesViewController {
            vc.viewModel = ListQuotesViewModel(currencyList: viewModel.currencyList)
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    private func resetInputs() {
        currencyFrom.text = ""
        currencyTo.text = ""
    }
    
    @IBAction func fromCurrencyAction(_ sender: Any) { segue(buttonType: .from) }
    @IBAction func toCurrencyAction(_ sender: Any) { segue(buttonType: .to) }
    @IBAction func invertCurrency(_ sender: Any) { viewModel.swapCurrency() }
    
}

extension CurrencyConverterViewController: ListQuoteDelegate {
    func didSelectedCurrency(for currency: Currency) {
        viewModel.setNewCurrency(currency: currency)
        resetInputs()
        updateButton()
    }
}

extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    func swapValues() {
        self.updateView()
        self.resetInputs()
    }
    
    func updateValue() {
        DispatchQueue.main.async { self.updateConvertValue() }
    }
    
    func updateView() {
        DispatchQueue.main.async { self.updateButton() }
    }
}
