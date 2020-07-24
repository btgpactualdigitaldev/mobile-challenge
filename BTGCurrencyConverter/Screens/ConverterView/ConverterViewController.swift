//
//  ConverterViewController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    let viewModel: ConverterViewModel
    
    let subview = UIView()
    let baseConversion = BTGBaseConversionViewController()
    let targetConversion = BTGTargetConversionViewController()
    
    init(viewModel: ConverterViewModel = ConverterViewModel.shared) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureSubView()
        configureBaseConversion()
        configureTargetConversion()
        createDismissKeyboardTapGesture()
    }
    
    
    func dismissListViews() {
        baseConversion.dismissViewController()
        targetConversion.dismissViewController()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(named: .background)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureSubView() {
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                             constant: padding),
            subview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                              constant: -padding)
        ])
    }
    
    private func configureBaseConversion() {
        subview.addSubview(baseConversion.view)
        baseConversion.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(baseConversion)
        baseConversion.didMove(toParent: self)
        baseConversion.delegate = self
        
        NSLayoutConstraint.activate([
            baseConversion.view.topAnchor.constraint(equalTo: subview.topAnchor),
            baseConversion.view.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            baseConversion.view.trailingAnchor.constraint(equalTo: subview.trailingAnchor)
        ])
        
    }
    
    private func configureTargetConversion() {
        subview.addSubview(targetConversion.view)
        targetConversion.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(targetConversion)
        targetConversion.didMove(toParent: self)
        targetConversion.delegate = self
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            targetConversion.view.topAnchor.constraint(equalTo: baseConversion.view.bottomAnchor,
                                                       constant: padding),
            targetConversion.view.leadingAnchor.constraint(equalTo:
                baseConversion.view.leadingAnchor),
            targetConversion.view.trailingAnchor.constraint(equalTo:
                baseConversion.view.trailingAnchor),
            targetConversion.view.bottomAnchor.constraint(equalTo: subview.bottomAnchor)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        baseConversion.dismissKeyboard()
    }
}

extension ConverterViewController: ConverterDelegate {
    func requestConversion() {
        guard let baseCurrency = baseConversion.getValues().currency,
            let targetCurrency = targetConversion.getValues(),
            let amount = baseConversion.getValues().amount,
            !amount.isEmpty else {
                return
        }
        
        guard Double(amount) != nil else {
            let alertVC = UIAlertController(title: AlertController.errorTitle.rawValue,
                                            message: AlertController.mustContainNumbers.rawValue,
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: AlertController.cancelButton.rawValue,
                                            style: .cancel))
            present(alertVC, animated: true)
            return
        }
        
        viewModel.convertValue(from: baseCurrency, to: targetCurrency,
                               amount: amount) { [weak self] result in
            DispatchQueue.main.async {
                self?.targetConversion.setLabel(text: result)
            }
        }
    }
}
