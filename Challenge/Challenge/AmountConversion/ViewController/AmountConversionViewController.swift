//
//  AmountConversioViewController.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

internal final class AmountConversionViewController: UIViewController {
    
    internal var theView: ConversionView {
        return view as! ConversionView
    }
    internal var availableCurrencies: [Dictionary<String, String>.Element] = []
    internal var conversionValues: [String : Double] = [:]
    internal var selectedCurrency = ""

    override func loadView() {
        let conversionView = ConversionView()
        conversionView.buttonDelegate = self
        view = conversionView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showPickerView(_ action: WithAction) {
        let alert = UIAlertController(
            title: action == WithAction.origin
                ? "Origin currency"
                : "Target currency",
            message: "\n\n\n\n\n\n\n\n",
            preferredStyle: .alert
        )
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 40, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (UIAlertAction) in
            if action == .origin, self?.selectedCurrency != "" {
                self?.theView.originMoneyButton.setTitle(self?.selectedCurrency, for: .normal)
            } else if self?.selectedCurrency != "" {
                self?.theView.targetMoneyButton.setTitle(self?.selectedCurrency, for: .normal)
            }
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    private func submitAction() {
        if let count = theView.targetMoneyButton.titleLabel?.text?.count {
            if count > 3 {
                showErrorAlert(message: "Please select some currency to convert the typed amount", title: "Invalid target currency")
                return
            }
        }
        guard let typedValue = Double(String(theView.amountTextField.text!)) else {
            showErrorAlert(message: "Please input some valid number", title: "Invalid input value")
            return
        }
        
        if typedValue == 0 {
            showErrorAlert(message: "Only values greater than zero are allowed.", title: "Invalid input value")
        }

        if Array(conversionValues.keys).count <= 1 {
            //                let source: Router =
            //                theView.originMoneyButton.titleLabel?.text == "USD"
            //                        ? .liveConversionDefault
            //                    : .liveConversionWithSource(currency: theView.originMoneyButton.titleLabel?.text ?? "USD")
            //MARK: - Free account limits only for USD as source
            startLoading(onView: view)
            ApiRequests.request(.liveConversionDefault) { [weak self] (response: ConversionLive?, error: String?) in
                if let response = response {
                    self?.conversionValues = response.quotes
                    DispatchQueue.main.async {
                        self?.stopLoading()
                        self?.theView.convertedAmount.text = self?.calculateAmount(typedValue)
                    }
                }
                if let error = error {
                    DispatchQueue.main.async { [weak self] in
                        self?.stopLoading()
                        self?.showErrorAlert(message: error)
                    }
                }
            }
        }
        else {
            theView.convertedAmount.text = calculateAmount(typedValue)
        }
    }
    
    internal func calculateAmount(_ inputValue: Double) -> String {
        var currency = ""
        if let origin = theView.originMoneyButton.titleLabel?.text, let target = theView.targetMoneyButton.titleLabel?.text {
            currency = "\(origin)\(target)"
        }
        
        let multiplier: Double = conversionValues.first(where: { $0.key == currency })?.value ?? 0
        var amount = inputValue
        amount = amount * multiplier
        return "1 USD = \(String(format: "%.2f", multiplier)) \(currency.suffix(3))\nTotal is: \(String(format: "%.2f", amount)) \(currency.suffix(3))"
    }

}

extension AmountConversionViewController: ButtonDelegate {

    func didPressButton(_ action: WithAction) {
        switch action {
        case .origin, .target:
            if availableCurrencies.count < 1 {
                startLoading(onView: view)
                ApiRequests.request(.availableList) { [weak self] (response: CurrencyList?, error: String?) in
                    if let response = response {
                        self?.availableCurrencies = Array(response.currencies.sorted{ $0.key < $1.key })
                        DispatchQueue.main.async {
                            self?.showPickerView(action)
                            self?.stopLoading()
                        }
                    }
                    if let error = error {
                        DispatchQueue.main.async { [weak self] in
                            self?.stopLoading()
                            self?.showErrorAlert(message: error)
                        }
                    }
                }
            }
            else {
                showPickerView(action)
            }
        case .submit:
            return submitAction()
        }
        
    }

}
