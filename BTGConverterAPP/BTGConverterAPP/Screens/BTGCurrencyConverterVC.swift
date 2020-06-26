//
//  BTGCurrencyConverterViewController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

protocol CurrencyResultHandler: UIViewController {
    func setCurrencyConversionResult(currencyConvertedResult: String)
    func setLastTimeUpdated(date: String)
}

protocol CurrencySelectionHandler: UIViewController {
    func setBaseCurrency(currencyAbbreviation: String)
    func setTargetCurrency(currencyAbbreviation: String)
    func setKeyboardNecessary(to : Bool)
}

enum AvaliableCurrencySelection {
    case base
    case target
}

final class BTGCurrencyConverterVC: UIViewController {
    
    private let titleView = BTGConverterTitleCard()
    private let baseCurrencyCardView = BTGConverterCardItem(itemType: .base)
    private let targetCurrencyCardView = BTGConverterCardItem(itemType: .target)
    private let resultCurrencyView = BTGConverterResultCardItem()
    private let changeBaseTargetButton = UIButton(type: .roundedRect)
    
    private let horizontalPadding : CGFloat = 15
    private let verticalPadding : CGFloat = 15
    private let cardTitleLabelFontSize : CGFloat = 26
    private var isKeyboardChangeNecessary = true
    
    private var currencyListModalView : BTGCurrencyListVC?
    private var controller : CurrencyConverterController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isKeyboardChangeNecessary = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isKeyboardChangeNecessary = false
    }
    
    private func configure() {
        configureCurrencyListModalView()
        configureController()
        configureTitleView()
        configureBaseCurrencyView()
        configureTargetCurrencyView()
        configureResultCurrencyView()
        createKeyboardGesture()
        configureChangeBaseTargetCurrenciesButtom()
    }
    
    func configureChangeBaseTargetCurrenciesButtom() {
        view.addSubview(changeBaseTargetButton)
        changeBaseTargetButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 41, weight: .black, scale: .large )
        let symbol = UIImage(systemName: SFSymbolsConstants.arrowUpDown.rawValue)
        changeBaseTargetButton.setImage(symbol, for: .normal)
        changeBaseTargetButton.tintColor = .systemGray
        changeBaseTargetButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        changeBaseTargetButton.addTarget(self, action: #selector(changeBaseTargetTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            changeBaseTargetButton.heightAnchor.constraint(equalTo: baseCurrencyCardView.heightAnchor, multiplier: 0.5),
            changeBaseTargetButton.widthAnchor.constraint(equalTo: baseCurrencyCardView.heightAnchor, multiplier: 0.5),
            changeBaseTargetButton.bottomAnchor.constraint(equalTo: targetCurrencyCardView.topAnchor, constant: 35),
            changeBaseTargetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding)
        ])
    }
    
    private func configureCurrencyListModalView() {
        currencyListModalView = BTGCurrencyListVC(isModalView: true, currencySelectionHandler: self)
    }
    
    private func configureBaseCurrencyView() {
        view.addSubview(baseCurrencyCardView)
        
        baseCurrencyCardView.selectCurrencyButton.addTarget(self, action: #selector(showBaseCurrencyListButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            baseCurrencyCardView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: verticalPadding),
            baseCurrencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            baseCurrencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            baseCurrencyCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }
    
    private func configureTargetCurrencyView() {
        view.addSubview(targetCurrencyCardView)
        targetCurrencyCardView.selectCurrencyButton.addTarget(self, action: #selector(showTargetCurrencyListButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            targetCurrencyCardView.topAnchor.constraint(equalTo: baseCurrencyCardView.bottomAnchor, constant: verticalPadding),
            targetCurrencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            targetCurrencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            targetCurrencyCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }
    
    private func configureResultCurrencyView() {
        view.addSubview(resultCurrencyView)
        resultCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        resultCurrencyView.layer.cornerRadius = 13
        resultCurrencyView.backgroundColor = .systemGray4
        resultCurrencyView.convertButton.addTarget(self, action: #selector(convertValueButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resultCurrencyView.topAnchor.constraint(equalTo: targetCurrencyCardView.bottomAnchor, constant: verticalPadding),
            resultCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            resultCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            resultCurrencyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureTitleView() {
        
        view.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.shareButton.addTarget(self, action: #selector(shareToFriendsCurrencyTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding ),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            titleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func createKeyboardGesture() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        resultCurrencyView.currencyTextField.delegate = self
    }
    
    private func configureController() {
        controller = BTGCurrencyConverterController(view: self)
    }
    
    private func convertValueControllerCall() {
        if controller.validateUserInput(userValueInput: resultCurrencyView.currencyTextField.text,
                                        baseCurrency: baseCurrencyCardView.currencyLabel.text,
                                        targetCurrency: targetCurrencyCardView.currencyLabel.text) {
            resultCurrencyView.currencyTextField.resignFirstResponder()
            let decimal = Decimal(string: resultCurrencyView.currencyTextField.text!)!
            controller.getCurrencyConversion(baseCurrency: baseCurrencyCardView.currencyLabel.text!, targetCurrency: targetCurrencyCardView.currencyLabel.text!, inputBaseDecimal: decimal)
        }
    }
    
    private func showCurrencyListButtonTap(_ avaliableCurrencySelection :AvaliableCurrencySelection) {
        currencyListModalView?.setModalSelection(avaliableCurrencySelection)
        let navController = UINavigationController(rootViewController: currencyListModalView!)
        present(navController,animated: true)
        isKeyboardChangeNecessary = false
    }
    
    @objc func changeBaseTargetTap() {
        let tempBaseText = baseCurrencyCardView.currencyLabel.text
        baseCurrencyCardView.currencyLabel.text = targetCurrencyCardView.currencyLabel.text
        targetCurrencyCardView.currencyLabel.text = tempBaseText
    }
    
    @objc private func convertValueButtonTap() {
        showLoadingView()
        convertValueControllerCall()
        dismissLoadingView()
    }
    
    @objc private func showTargetCurrencyListButtonTap() {
        showCurrencyListButtonTap(.target)
    }
    
    @objc private func showBaseCurrencyListButtonTap() {
        showCurrencyListButtonTap(.base)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, isKeyboardChangeNecessary else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        if notification.name != UIResponder.keyboardWillHideNotification &&
            self.view.frame.origin.y == 0 {
            self.view.frame.origin.y = 0 - keyboardScreenEndFrame.height + 120
        } else if notification.name == UIResponder.keyboardWillHideNotification &&
            self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += keyboardScreenEndFrame.height - 120
        }
    }
    
    @objc func shareToFriendsCurrencyTap() {
        guard let currencyResult = resultCurrencyView.convertResultLabel.text,
            let baseCurrecy = baseCurrencyCardView.currencyLabel.text,
            let targetCurrency = targetCurrencyCardView.currencyLabel.text,
            let inputValue = resultCurrencyView.currencyTextField.text else {
                showErrorMessage(message: BTGCurrencyErrorConstants.shareTappedBeforeAnyConversion.rawValue)
                return
        }
        
        let recommendationMessage = "I've converted \(inputValue) \(baseCurrecy) to \(currencyResult) \(targetCurrency). With this awesome app, you should try!"
        let vc = UIActivityViewController(activityItems: [recommendationMessage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated:true)
    }
    
}

extension BTGCurrencyConverterVC: CurrencyResultHandler {
    func setCurrencyConversionResult(currencyConvertedResult: String) {
        resultCurrencyView.convertResultLabel.text = currencyConvertedResult
    }
    func setLastTimeUpdated(date: String) {
        titleView.lastTimeUpdatedLabel.text = "Last Updated: \(date)"
    }
    
}

extension BTGCurrencyConverterVC: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        convertValueControllerCall()
        textField.resignFirstResponder()
        return true
    }
}

extension BTGCurrencyConverterVC: CurrencySelectionHandler {
    
    func setKeyboardNecessary(to value: Bool) {
        isKeyboardChangeNecessary = value
    }

    func setBaseCurrency(currencyAbbreviation: String) {
        baseCurrencyCardView.currencyLabel.text = currencyAbbreviation
    }
    
    func setTargetCurrency(currencyAbbreviation: String) {
        targetCurrencyCardView.currencyLabel.text = currencyAbbreviation
    }
}
