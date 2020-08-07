//
//  ExchangeViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class ExchangeViewController: FloatViewController {
    let viewModel: ExchangeViewModel
    @IBOutlet weak var localTextField: UITextField!
    @IBOutlet weak var foreignTextField: UITextField!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var foreignLabel: UILabel!
    @IBOutlet weak var infoOfflineContainer: UIView!
    @IBOutlet weak var infoOfflineLabel: UILabel!
    @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
    
    init(localCurrency: Currency, foreignCurrency: Currency) {
        self.viewModel = ExchangeViewModel(localCurrency: localCurrency, foreignCurrency: foreignCurrency)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("🔥")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configTextFields()
        viewModel.setLabels(localLabel: localLabel, foreignLabel: foreignLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createKeyboardObserver(contentBottomConstraint: contentBottomConstraint)
        localTextField.becomeFirstResponder()
        viewModel.checkConnection(container: infoOfflineContainer, label: infoOfflineLabel)
    }

    @IBAction func changeCurrencies(_ sender: Any) {
        viewModel.goToList()
    }
}

//MARK: - Configuração do textfield
extension ExchangeViewController: UITextFieldDelegate {
    func configTextFields() {
        localTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if let value = Double(textField.text!.replacingOccurrences(of: ",", with: ".")) {
            textField.text = textField.text?.noLeadingZeros
            let convertedValue = viewModel.convertLocalToForeign(value: value)
            foreignTextField.text = "\(convertedValue)".replacingOccurrences(of: ".", with: ",")
        } else {
            foreignTextField.text = "0"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModel.isValueDecimal(textField: textField, typedValue: string)
    }
}
