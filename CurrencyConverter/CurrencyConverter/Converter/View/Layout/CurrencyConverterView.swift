//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

protocol CurrencyConverterViewDelegate: class {
    func textFormatting(_ text: String?) -> (input: String, output: String)
}

class CurrencyConverterView: UIView {
    
    weak var delegate: CurrencyConverterViewDelegate?
    
    // MARK: - Layout Vars
    private lazy var titleOriginLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = Style.defaultFont
        label.textColor = Style.defaultPrimaryTextColor
        return label
    }()
    
    private lazy var valueOriginTextField: UITextField = {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: Style.highlightFont]
        let textField = UITextField().useConstraint()
        textField.attributedPlaceholder = NSAttributedString(string: Style.Home.Conversor.inputPlaceholder, attributes: attributes)
        textField.textColor = Style.defaultPrimaryTextColor
        textField.font = Style.highlightFont
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var stackViewOrigin: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleOriginLabel, valueOriginTextField]).useConstraint()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var titleTargetLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = Style.defaultFont
        label.textColor = Style.defaultPrimaryTextColor
        return label
    }()
    
    private lazy var valueTargetLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = Style.highlightFont
        label.textColor = Style.defaultPrimaryTextColor
        return label
    }()
    
    private lazy var stackViewTarget: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTargetLabel, valueTargetLabel]).useConstraint()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView().useConstraint()
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        addSubview(stackViewOrigin)
        addSubview(stackViewTarget)
        addSubview(separatorView)
        
        stackViewOrigin
            .top(anchor: topAnchor, constant: Style.defaultCloseTop)
            .leading(anchor: leadingAnchor, constant: Style.defaultCloseLeading)
            .trailing(anchor: trailingAnchor, constant: Style.defaultCloseTrailing)
        
        stackViewTarget
            .top(anchor: stackViewOrigin.bottomAnchor, constant: Style.defaultTop)
            .leading(anchor: leadingAnchor, constant: Style.defaultCloseLeading)
            .trailing(anchor: trailingAnchor, constant: Style.defaultCloseTrailing)
            .bottom(anchor: bottomAnchor, constant: Style.defaultCloseBottom)
        
        separatorView
            .top(anchor: stackViewOrigin.bottomAnchor, constant: Style.defaultTop / 2)
            .leading(anchor: leadingAnchor, constant: Style.defaultCloseLeading)
            .trailing(anchor: trailingAnchor)
            .height(constant: Style.Home.Conversor.separatorHeight)
        
        titleOriginLabel
            .height(constant: Style.Home.Conversor.titleHeight)
        
        valueOriginTextField
            .height(constant: Style.Home.Conversor.valueFieldHeight)
        
        titleTargetLabel
            .height(constant: Style.Home.Conversor.titleHeight)
        
        valueTargetLabel
            .height(constant: Style.Home.Conversor.valueFieldHeight)
    }
    
    func setupCurrency(_ currency: Currecy, type: CurrencyType) {
        valueOriginTextField.text = nil
        valueTargetLabel.text = nil
        
        switch type {
        case .origin:
            titleOriginLabel.text = currency.fullDescription
        case .target:
            titleTargetLabel.text = currency.fullDescription
        }
    }
}

// MARK: - TextField
extension CurrencyConverterView: UITextFieldDelegate {
    @objc func textDidChange(_ textField: UITextField) {
        let texts = delegate?.textFormatting(textField.text)
        textField.text = texts?.input
        valueTargetLabel.text = texts?.output
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
}
