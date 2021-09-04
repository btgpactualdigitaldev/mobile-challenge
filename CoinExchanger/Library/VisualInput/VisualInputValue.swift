//
//  VisualInputValue.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class VisualInputValue: VisualInput {
    var currency = Constants.code { didSet { textFieldDidChange() } }
    private var didBackspace = false
    private var enteredNumbers = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func deleteBackward() {
        enteredNumbers = String(enteredNumbers.dropLast())
        text = enteredNumbers.asCurrency(currency)
        didBackspace = true
        super.deleteBackward()
    }
    
    func setText(_ value: Double) {
        let text = "\(value)"
        self.text = text.asCurrency(currency)
        enteredNumbers = Sanityze.number(text)
    }
    
    func setText(_ text: String?) {
        let value = Sanityze.number(text ?? "")
        enteredNumbers = value
        self.text = text
    }
}

private extension VisualInputValue {
    func setup() {
        keyboardType = .numberPad
        textAlignment = .right
        
        self.addTarget(self,
                       action: #selector(textFieldDidChange),
                       for: .editingChanged)
    }
    
    @objc
    func textFieldDidChange() {
        defer {
            didBackspace = false
            text = enteredNumbers.asCurrency(currency)
            visualDelegate?.didChange(self)
        }

        guard didBackspace == false else { return }

        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
            enteredNumbers.append(lastEnteredCharacter)
        }
        
    }
}

private extension String {
    func asCurrency(_ currency: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: currency)
        formatter.currencyCode = currency
        
        return self.isEmpty
            ? formatter.string(from: 0)
            : formatter.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
    }
}
