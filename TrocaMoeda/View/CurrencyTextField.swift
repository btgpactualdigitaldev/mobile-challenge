//
//  CurrencyTextField.swift
//  TrocaMoeda
//
//  Created by mac on 25/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {
    
    public var enteredNumbers = ""

    private var didBackspace = false

    var locale: Locale = .current

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    override func deleteBackward() {
        enteredNumbers = String(enteredNumbers.dropLast())
        text = enteredNumbers.asCurrency(locale: locale)
        // Call super so that the .editingChanged event gets fired, but we need to handle it differently, so we set the `didBackspace` flag first
        didBackspace = true
        super.deleteBackward()
    }

    @objc func editingChanged() {
        defer {
            didBackspace = false
            text = enteredNumbers.asCurrency(locale: locale)
        }

        guard didBackspace == false else { return }

        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
            enteredNumbers.append(lastEnteredCharacter)
        }
    }
    
    func addValue(amount: String) {
        var amountText = text ?? "0.0"
        if amountText == "" {
            amountText = "0"
        }
        if amountText.contains(".") {
            amountText = String(amountText.split(separator: ".").joined())
        }
            let formatter = NumberFormatter()
            if let number = formatter.number(from: amountText) {
                let givenAmount = number.doubleValue
                    if let amountToAdd = Double(amount.split(separator: "+")[0]) {
                        let partialAmount = Double(amountToAdd + givenAmount) * 100.0
                        let pAtext = partialAmount
                        enteredNumbers = String(pAtext)
                        text = enteredNumbers.asCurrency(locale: locale)
                        amountText = text!
                    }
                }
            
    }
}

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        return formatter
    }()
}

extension String {
    func asCurrency(locale: Locale) -> String? {
        Formatter.currency.locale = locale
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
        }
    }
}
