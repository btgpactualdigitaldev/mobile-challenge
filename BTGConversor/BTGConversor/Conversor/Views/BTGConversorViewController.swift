//
//  BTGConversorViewController.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import UIKit

final class BTGConversorViewController: UIViewController {
    
    @IBOutlet weak private var currencyFromButton: UIButton!
    @IBOutlet weak private var currencyToButton: UIButton!
    @IBOutlet weak private var currencyFromTextField: UITextField!
    @IBOutlet weak private var currencyToTextField: UITextField!
    
    var viewModel: BTGConversorViewModel
    
    init(_ viewModel: BTGConversorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should not be used")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        viewModel.viewDelegate = self
        setupButton()
        setTextField()
        viewModel.fetchQuota()

    }
    
    private func setTextField() {
        currencyToTextField.isUserInteractionEnabled = false
        currencyFromTextField.inputView = nil
        currencyFromTextField.delegate = self
    }
    
    private func setupButton() {
        currencyFromButton.setTitle(viewModel.currencyFrom, for: .normal)
        currencyToButton.setTitle(viewModel.currencyTo, for: .normal)
    }
    
    @IBAction private func didTapCurrencyFrom(_ sender: UIButton) {
        viewModel.didTapCurrencyFrom()
        currencyFromButton.setTitle(viewModel.currencyFrom, for: .normal)
    }

    @IBAction private func didTapCurrencyTo(_ sender: UIButton) {
        viewModel.didTapCurrencyTo()
        currencyToButton.setTitle(viewModel.currencyTo, for: .normal)
    }
    
}

extension BTGConversorViewController: BTGConversorViewDelegate {

    func updateConversion(_ viewModel: BTGConversorViewModel, value: String?) {
        currencyFromTextField.text = value
    }
    
    
    func updateCurrencyFrom(_ viewModel: BTGConversorViewModel, title: String) {
        currencyFromButton.setTitle(title, for: .normal)
    }
    
    func updateCurrencyTo(_ viewModel: BTGConversorViewModel, title: String) {
        currencyToButton.setTitle(title, for: .normal)
    }
    
    func updateConversionResult(_ viewModel: BTGConversorViewModel, value: String?) {
        currencyToTextField.text = value
    }
    
    func clearTextField(_ viewModel: BTGConversorViewModel) {        
        currencyFromTextField.text = ""
    }
    
    func enableTextField(_ viewModel: BTGConversorViewModel) {
        DispatchQueue.main.async {
            self.currencyFromTextField.inputView = UIView()
        }
        
    }
}

extension BTGConversorViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        viewModel.getAmountString(string)
        return false
    }
}
