//
//  CurrencyTextField.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

@propertyWrapper class CurrencyTextField<T: PaddingTextField> {

    var onTextChanged: (String) -> Void = { _ in }

    private let formatter = NumberFormatter()
    private let currencyType: CurrencyConverterViewModel.CurrencyType

    private lazy var textField: T = {
        let textField = T()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .decimalPad
        textField.layer.borderWidth = DesignSystem.TextField.borderWidth
        textField.layer.borderColor = DesignSystem.Color.border.cgColor
        textField.layer.cornerRadius = DesignSystem.TextField.cornerRadius
        textField.inputAccessoryView = inputAccessoryView
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.large)
        textField.isEnabled = currencyType == .origin ? true : false
        textField.textColor = currencyType == .origin
            ? DesignSystem.Color.primaryText
            : DesignSystem.Color.gray

        textField.addAction(UIAction(handler: { [weak self] _ in
            self?.onTextChanged(textField.text ?? "")
        }), for: .editingChanged)

        textField.addSubview(currencyCodeView)

        formatter.numberStyle = .currency
        textField.placeholder = formatter.string(from: 0)?.replacingOccurrences(of: formatter.currencySymbol, with: "")

        return textField
    }()

    private lazy var currencyCodeView: UIView = {
        let view = UIView(frame: DesignSystem.CurrencyCodeView.frame)
        view.backgroundColor = DesignSystem.Color.currencyCodeView
        view.layer.cornerRadius = DesignSystem.CurrencyCodeView.cornerRadius

        view.addSubview(currencyCodeLabel)
        NSLayoutConstraint.activate([
            currencyCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyCodeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }()

    private lazy var currencyCodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.large)

        return label
    }()

    private lazy var inputAccessoryView: UIView = {
        let blurEffect = UIBlurEffect(style: .prominent)

        let view = UIVisualEffectView(effect: blurEffect)
        view.frame = DesignSystem.InputAccessoryView.frame

        let button = CustomButton(frame: DesignSystem.InputAccessoryViewButton.frame)
        button.setTitle(LiteralText.done, for: .normal)
        button.setTitleColor(DesignSystem.Color.action, for: .normal)

        button.addAction(UIAction(handler: { [weak self] _ in
            self?.textField.endEditing(true)
        }), for: .touchUpInside)

        view.contentView.addSubview(button)

        return view
    }()

    var wrappedValue: T {
        return textField
    }

    init(_ currencyType: CurrencyConverterViewModel.CurrencyType) {
        self.currencyType = currencyType
    }

    /// Sets currency code for currency label
    /// - Parameter code: currency  code
    func setCurrencyCode(_ code: String) {
        currencyCodeLabel.text = code
    }

    /// Sets currencyTextField text
    /// - Parameter text: text to placed into textField
    func setText(_ text: String) {
        textField.text = text
    }
}
