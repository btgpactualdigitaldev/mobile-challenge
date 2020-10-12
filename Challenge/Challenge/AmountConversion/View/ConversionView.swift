//
//  ConversionView.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//
//* Dois botões que permitam o usuário a escolher as moedas de origem e de destino.
//* Um campo de entrada de texto onde o usuário possa inserir o valor a ser convertido.
//* Uma campo de texto para apresentar o valor convertido.

import UIKit

internal class ConversionView: UIView {

    internal let originMoneyButton: UIButton!
    internal let originLabel: UILabel!
    internal let targetMoneyButton: UIButton!
    internal let targetLabel: UILabel!
    internal let amountTextField: UITextField!
    internal let convertedAmount: UILabel!
    internal let submitButton: UIButton!
    
    weak var buttonDelegate: ButtonDelegate!
    
    override init(frame: CGRect) {
        originMoneyButton = UIButton()
        targetMoneyButton = UIButton()
        amountTextField = UITextField()
        convertedAmount = UILabel()
        originLabel = UILabel()
        targetLabel = UILabel()
        submitButton = UIButton()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapOriginButton() {
        buttonDelegate.didPressButton(.origin)
    }
    
    @objc func didTapTargetButton() {
        buttonDelegate.didPressButton(.target)
    }
    
    @objc func didTapSubmitButton() {
        buttonDelegate.didPressButton(.submit)
    }
}

extension ConversionView: ViewCodable {

    internal func buildView() {
        [
            originMoneyButton,
            originLabel,
            targetMoneyButton,
            targetLabel,
            amountTextField,
            convertedAmount,
            submitButton
            ].forEach(
                { view in
                    if let view = view {
                        addSubview(view)
                        view.translatesAutoresizingMaskIntoConstraints = false
                    }
                }
        )
    }

    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            originLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            originLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            originLabel.heightAnchor.constraint(equalToConstant: 50),
            originLabel.bottomAnchor.constraint(equalTo: originMoneyButton.topAnchor, constant: -16),
            
            originMoneyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            originMoneyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            originMoneyButton.heightAnchor.constraint(equalToConstant: 50),
            originMoneyButton.bottomAnchor.constraint(equalTo: targetLabel.topAnchor, constant: -16),
            
            targetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            targetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            targetLabel.heightAnchor.constraint(equalToConstant: 50),
            targetLabel.bottomAnchor.constraint(equalTo: targetMoneyButton.topAnchor, constant: -16),
            
            targetMoneyButton.topAnchor.constraint(equalTo: originMoneyButton.bottomAnchor, constant: 16),
            targetMoneyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            targetMoneyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            targetMoneyButton.heightAnchor.constraint(equalToConstant: 50),
            targetMoneyButton.bottomAnchor.constraint(equalTo: amountTextField.topAnchor, constant: -16),
            
            amountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            submitButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 24),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            convertedAmount.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 24),
            convertedAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            convertedAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    internal func setupAdditionalConfig() {
        
        //MARK: - Free account limits only for USD as source
//        originMoneyButton.addTarget(self, action: #selector(didTapOriginButton), for: .touchUpInside)
        targetMoneyButton.addTarget(self, action: #selector(didTapTargetButton), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)

        originLabel.text = "From :"
        originLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        originLabel.textColor = .black
        
        originMoneyButton.setTitle("USD", for: .normal)
        originMoneyButton.setTitleColor(.black, for: .normal)
        originMoneyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        targetLabel.text = "To :"
        targetLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        targetLabel.textColor = .black
        
        targetMoneyButton.setTitle("Choose target currency", for: .normal)
        targetMoneyButton.setTitleColor(.black, for: .normal)
        targetMoneyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        amountTextField.placeholder = "0.00"
        amountTextField.keyboardType = .decimalPad
        amountTextField.font = UIFont.systemFont(ofSize: 24)
        amountTextField.placeholderColor(color: .white)
        amountTextField.textColor = .white
        amountTextField.textAlignment = .center
        amountTextField.addDoneButtonOnKeyboard()
        
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        
        convertedAmount.font = UIFont.systemFont(ofSize: 24, weight: .light)
        convertedAmount.numberOfLines = 0
        convertedAmount.textColor = .black
        convertedAmount.textAlignment = .center
        convertedAmount.text = "Total amount is:\n0.00"
    }
    
    internal func render() {
        backgroundColor = .white
        
        originMoneyButton.layer.borderColor = UIColor.black.cgColor
        originMoneyButton.layer.borderWidth = 1
        originMoneyButton.layer.cornerRadius = 25
        
        targetMoneyButton.layer.borderColor = UIColor.black.cgColor
        targetMoneyButton.layer.borderWidth = 1
        targetMoneyButton.layer.cornerRadius = 25

        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.cornerRadius = 8
        
        amountTextField.layer.cornerRadius = 25
        amountTextField.backgroundColor = .darkGray
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16, height: 1))
        amountTextField.leftView = paddingView
        amountTextField.rightView = paddingView
        amountTextField.leftViewMode = .always
        amountTextField.rightViewMode = .always
    }

}
