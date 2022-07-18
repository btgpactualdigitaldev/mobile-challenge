//
//  ConversionView.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 15/07/22.
//

import UIKit

protocol ConversionViewDelegate: AnyObject {
    func didTapInitialCurrency()
    func didTapFinalCurrency()
    func didTapDoneButton()
}

class ConversionView: UIView {
    
    var viewModel: ConversionViewModelProtocol
    var delegate: ConversionViewDelegate?
    var textFieldEnableCount = 0
    
    init(frame: CGRect = .zero, viewModel: ConversionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel.conversionViewModelDelegate = self
        setupView()
        viewModel.fetchQuotationLive()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.8
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "0.00"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private lazy var convertedValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 40)
        label.sizeToFit()
        return label
    }()
    
    private lazy var initialCurrencyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapInitialCurrency), for: .touchUpInside)
        button.setTitle("Selecione Moeda inicial", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var finalCurrencyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapFinalCurrency), for: .touchUpInside)
        button.setTitle("Selecione Moeda final", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private func setupTextFields() {
            let toolbar = UIToolbar()
        
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        
            toolbar.setItems([flexSpace, doneButton], animated: true)
            toolbar.sizeToFit()
        
            inputTextField.inputAccessoryView = toolbar
    }
    
   private func enableInputTextField() {
        textFieldEnableCount = 0
        inputTextField.isUserInteractionEnabled = true
        inputTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func tapAnywhereOnScreenToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    private func textChanged(text: String) {
        viewModel.onValueChange(value: Float(text) ?? 0)
    }

    @objc private func didTapInitialCurrency() {
        delegate?.didTapInitialCurrency()
    }
    
    @objc private func didTapFinalCurrency() {
        delegate?.didTapFinalCurrency()
    }
    
    @objc private func didTapDoneButton() {
        delegate?.didTapDoneButton()
    }

}

extension ConversionView: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(convertedValueLabel)
        stackView.addArrangedSubview(inputTextField)
        stackView.addArrangedSubview(initialCurrencyButton)
        stackView.addArrangedSubview(finalCurrencyButton)
    }
    
    func setupConstraints() {
        convertedValueLabel.anchor(widthConstant: 200, heightConstant: 40)
        inputTextField.anchor(widthConstant: 200, heightConstant: 40)
        initialCurrencyButton.anchor(widthConstant: 200, heightConstant: 40)
        finalCurrencyButton.anchor(widthConstant: 200, heightConstant: 40)
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 150, rightConstant: 20)
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
        setupTextFields()
        tapAnywhereOnScreenToDismissKeyboard()
    }
    
}

extension ConversionView: UITextFieldDelegate {
    @objc func textFieldDidChange() {
        if let text = inputTextField.text {
            textChanged(text: text)
        }
    }
}

extension ConversionView: ConversionViewModelDelegate {
    func convertedValueDidChange(value: Float) {
        convertedValueLabel.text = String(value)
    }
    
    func initialCurrencyDidChange(currency: String) {
        initialCurrencyButton.setTitle(currency, for: .normal)
        textFieldEnableCount += 1
        if textFieldEnableCount == 2 {
            enableInputTextField()
        }
    }
    
    func finalCurrencyDidChange(currency: String) {
        finalCurrencyButton.setTitle(currency, for: .normal)
        textFieldEnableCount += 1
        if textFieldEnableCount == 2 {
            enableInputTextField()
        }
    }
}
