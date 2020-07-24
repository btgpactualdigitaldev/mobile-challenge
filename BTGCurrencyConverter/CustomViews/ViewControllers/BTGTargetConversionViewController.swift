//
//  BTGTargetConversionViewController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGTargetConversionViewController: UIViewController {
    private let titleLabel = BTGSecondaryTitleLabel(textAlignment: .center, fontSize: 16)
    private let button = BTGSelectionButton(title: ButtonTitles.selectCurrency.rawValue)
    private let label = BTGDisplayLabel()
    
    private var listViewController:  ListViewController?
    
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
    
    func dismissViewController() {
        listViewController?.dismiss(animated: true)
    }
    
    func getValues() -> String? {
        selectedCurrency?.symbol
    }
    
    func setLabel(text: String) {
        label.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureLabels()
        layoutUI()
        configureActions()
    }
    
    private func configureView() {
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: .accent)
    }
    private func configureLabels() {
        titleLabel.text = LabelTitles.targetCurrency.rawValue
        label.text = PlaceholderText.initialValue.rawValue
    }
    
    private func layoutUI() {
        view.addSubviews(titleLabel, button, label)
        let padding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureActions() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        listViewController = ListViewController(delegate: self)
        let navController = UINavigationController(rootViewController: listViewController!)
            navController.modalPresentationStyle = .overCurrentContext
        
        present(navController, animated: true)
    }
}

extension BTGTargetConversionViewController: ListViewSelectionDelegate {
    func didSelect(currency: Currency) {
        selectedCurrency = currency
    }
}
