//
//  BTGBaseConversionViewController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

protocol ConverterDelegate {
    func requestConversion()
}

class BTGBaseConversionViewController: UIViewController {
    private let titleLabel = BTGSecondaryTitleLabel(textAlignment: .center, fontSize: 16)
    private let button = BTGSelectionButton(title: ButtonTitles.selectCurrency.rawValue)
    private let textField = BTGNumberTextField()
    
    private var listViewController: ListViewController?
    
    private var selectedCurrency: Currency? {
        didSet {
            if let selectedCurrency = selectedCurrency {
                button.set(title: selectedCurrency.name)
                delegate?.requestConversion()
            } else {
                button.set(title: ButtonTitles.selectCurrency.rawValue)
            }
        }
    }
    
    var delegate: ConverterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureLabel()
        configureTextField()
        layoutUI()
        configureActions()
    }
    
    func dismissKeyboard() {
        textField.resignFirstResponder()
    }
    
    func dismissViewController() {
        listViewController?.dismiss(animated: true)
    }
    
    func getValues() -> (currency: String?, amount: String?) {
        (selectedCurrency?.symbol, textField.text)
    }
    
    private func configureView() {
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: .accent)
    }
    
    private func configureLabel() {
        titleLabel.text = LabelTitles.baseCurrency.rawValue
    }
    
    private func configureTextField() {
        textField.text = PlaceholderText.initialValue.rawValue
    }
    
    private func layoutUI() {
        view.addSubviews(titleLabel, button, textField)
        let padding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureActions() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        textField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
    }
    
    @objc private func textFieldEdited() {
        delegate?.requestConversion()
    }
    
    @objc private func buttonTapped() {
        listViewController = ListViewController(delegate: self)
        let navController = UINavigationController(rootViewController: listViewController!)
            navController.modalPresentationStyle = .overCurrentContext
        
        present(navController, animated: true)
    }
}

extension BTGBaseConversionViewController: ListViewSelectionDelegate {
    func didSelect(currency: Currency) {
        selectedCurrency = currency
    }
}
