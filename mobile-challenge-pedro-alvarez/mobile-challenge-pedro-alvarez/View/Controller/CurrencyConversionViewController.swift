 //
//  CurrencyConvertionViewController.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    
    private(set) lazy var firstCurrencyButton: CurrencyButton = {
        let button = CurrencyButton(frame: .zero,
                                    title: Constants.Button.firstCurrencyButton)
        button.addTarget(self,
                         action: #selector(didTapFirstCurrencyButton),
                         for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var currencyTextField: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
        return textfield
    }()
    
    private(set) lazy var secondCurrencyButton: CurrencyButton = {
        let button = CurrencyButton(frame: .zero,
                                    title: Constants.Button.secondCurrencyButton)
        button.addTarget(self,
                         action: #selector(didTapSecondCurrencyButton),
                         for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var convertActionButton: ConvertActionButton = {
        let button = ConvertActionButton(frame: .zero)
        button.addTarget(self,
                         action: #selector(didTapConvertActionButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var resultLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView(frame: .zero, errorMessage: .empty)
        return view
    }()
    
    private lazy var mainView: CurrencyConversionView = {
        return CurrencyConversionView(firstCurrencyButton: firstCurrencyButton,
                                      secondCurrencyButton: secondCurrencyButton,
                                      convertActionButton: convertActionButton,
                                      resultLbl: resultLbl,
                                      errorView: errorView,
                                      currencyTextField: currencyTextField)
    }()
    
    private var viewModel: CurrencyConversionViewModelProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchCurrencyValues()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
}

extension CurrencyConversionViewController {
    
    private func setupController() {
        title = Constants.Titles.convertionTitle
        navigationItem.backBarButtonItem = UIBarButtonItem(title: .empty, style: .plain, target: self, action: nil)
        self.viewModel = CurrencyConversionViewModel(delegate: self)
    }
    
    @objc
    private func didTapFirstCurrencyButton() {
        let currentyListVC = CurrencyListViewController(finishCallback: {
            self.firstCurrencyButton.setTitle($0, for: .normal)
            self.checkAvailabilityForConvertion()
        })
        navigationController?.pushViewController(currentyListVC, animated: true)
    }
    
    @objc
    private func didTapSecondCurrencyButton() {
        let currentyListVC = CurrencyListViewController(finishCallback: {
            self.secondCurrencyButton.setTitle($0, for: .normal)
            self.checkAvailabilityForConvertion()
        })
        navigationController?.pushViewController(currentyListVC, animated: true)
    }
    
    @objc
    private func didTapConvertActionButton() {
        mainView.endEditing(true)
        let firstCurrency: String = .usd + (firstCurrencyButton.titleLabel?.text ?? .empty)
        let secondCurrency: String = .usd + (secondCurrencyButton.titleLabel?.text ?? .empty)
        guard let value = currencyTextField.text,
            let double = value.toDouble() else { return }
        viewModel?.fetchConvertionResult(value: double, first: firstCurrency, second: secondCurrency)
    }
    
    @objc
    private func didChangeTextField() {
        if let text = currencyTextField.text, !text.isEmpty {
            checkAvailabilityForConvertion()
        } else {
            convertActionButton.isEnabled = false
        }
    }
    
    private func checkAvailabilityForConvertion() {
        if let firstId = self.firstCurrencyButton.titleLabel?.text,
            let secondId = self.secondCurrencyButton.titleLabel?.text,
        firstId != Constants.Button.firstCurrencyButton,
        secondId != Constants.Button.secondCurrencyButton,
            self.currencyTextField.text != .empty{
            self.convertActionButton.isEnabled = true
        }
    }
}

extension CurrencyConversionViewController: CurrencyConversionViewModelDelegate {
    
    func didFetchFirstCurrency(_ currency: String) {
        firstCurrencyButton.setTitle(currency, for: .normal)
    }
    
    func didFetchSecondCurrency(_ currency: String) {
        secondCurrencyButton.setTitle(currency, for: .normal)
    }
    
    func didFetchResult(_ result: NSAttributedString) {
        resultLbl.attributedText = result
    }
    
    func didGetError(_ error: String) {
        errorView.errorMessage = error
        errorView.isHidden = false
    }
}

