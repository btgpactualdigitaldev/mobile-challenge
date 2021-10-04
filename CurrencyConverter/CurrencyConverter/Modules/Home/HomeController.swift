//
//  HomeController.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

final class HomeController: UIViewController {
    private let customView = HomeView()
    private let viewModel: HomeViewModel
    var currencyCode: String = "BRL"
    var newCurrencyCode: String = "USD"
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.controllerDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldDidChange(customView.currencyTextField)
        setSufix(from: self.currencyCode, to: self.newCurrencyCode)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    private func setTargets() {
        customView.currencyButton.addTarget(viewModel, action: #selector(viewModel.didTapCurrency(_:)), for: .touchUpInside)
        customView.newCurrencyButton.addTarget(viewModel, action: #selector(viewModel.didTapNewCurrency), for: .touchUpInside)
        customView.currencyTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateValues(textField)
    }
    
    private func updateValues(_ textField: UITextField) {
        viewModel.formatTextField(customView.currencyTextField)
        guard let receivedValue = textField.text else {
            customView.newCurrencyLabel.text = String(format: "%.02f", 0)
            return
        }
        let from = self.currencyCode
        let to = self.newCurrencyCode
        if receivedValue != "" {
            let decimalValue = receivedValue.replacingOccurrences(of: ",", with: "")
            let converted = viewModel.convert(receivedValue: Double(decimalValue) ?? Double(0), from: from, to: to) / 100
            customView.newCurrencyLabel.text = String(format: "%.02f", converted)
            viewModel.formatTextField(customView.newCurrencyLabel)
            customView.currencyTextField.text = customView.currencyTextField.text?.maxLength(length: 23)
        } else {
            customView.newCurrencyLabel.text = String(format: "%.02f", 0)
        }
    }
    
    func setSufix(from: String, to: String) {
        customView.newCurrencySufix.text = "\(to)  "
        customView.currencySufix.text = "\(from)  "
    }
    
}

// MARK: - Extensions
extension HomeController: HomeControllerDelegate {
    func originUpdated(origin: Origin, title: String, currencyCode: String) {
        switch origin {
        case .currency:
            customView.currencyButton.setTitle(title, for: .normal)
            self.currencyCode = currencyCode
        case .newCurrency:
            customView.newCurrencyButton.setTitle(title, for: .normal)
            self.newCurrencyCode = currencyCode
        default:
            break
        }
    }
    
}
