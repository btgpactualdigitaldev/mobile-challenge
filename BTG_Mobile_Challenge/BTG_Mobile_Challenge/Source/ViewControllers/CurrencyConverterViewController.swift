//
//  CurrencyConverterViewController.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyConverterViewController: UIViewController {
    
    @AutoLayout private var currencyLabel: CurrencyLabel
    
    @AutoLayout private var resultCurrencyLabel: CurrencyLabel
    @AutoLayout private var amountInputTextField: CurrencyConverterTextField
    
    @AutoLayout private var fromCurrencyButton: ChangeCurrencyButton
    @AutoLayout private var toCurrencyButton: ChangeCurrencyButton
    
    @AutoLayout private var toCurrencyLabel: TargetingLabel
    @AutoLayout private var fromCurrencyLabel: TargetingLabel
    
    private let viewModel: CurrencyConverterViewModel
    
    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let viewModel = coder.decodeObject(forKey: "viewModel") as? CurrencyConverterViewModel else {
            return nil
        }
        self.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViewModel()
        setupViews()
        setupLayoutConstraints()
    }
    
    private func setupViewModel() {
        viewModel.fetchCurrencyLiveQuote()
        viewModel.delegate = self
    }
    
    private func setupViews() {
        setupLabels()
        setupTextField()
        setupButttons()
    }
    
    private func setupLayoutConstraints() {
        setupCurrencyLabelsConstraints()
        setupTextFieldConstraints()
        setupButtonConstraints()
        setupTargetingLabelsConstraints()
    }
    
    private func setupLabels() {
        currencyLabel.text = "Conversor de moedas"
        resultCurrencyLabel.text = "0"
        
        toCurrencyLabel.text = "To"
        fromCurrencyLabel.text = "From"
    }
    
    private func setupButttons() {
        fromCurrencyButton.setTitle("USD", for: .normal)
        toCurrencyButton.setTitle("BRL", for: .normal)
    }
    
    private func setupTextField() {
        amountInputTextField.addTarget(self, action: #selector(amountToBeConvertedDidChange), for: .editingChanged)
    }
    
    private func setupCurrencyLabelsConstraints() {
        self.view.addSubview(currencyLabel)
        self.view.addSubview(resultCurrencyLabel)
        
        currencyLabel.addAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: 40, left: -14, bottom: 0, right: -14), widht: nil, height: 60)
        
        resultCurrencyLabel.addAnchor(top: self.currencyLabel.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: 30, left: -14, bottom: 0, right: -14), widht: nil, height: 80)
    }
    
    private func setupTextFieldConstraints() {
        self.view.addSubview(amountInputTextField)
        
        amountInputTextField.addAnchor(top: self.resultCurrencyLabel.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 20), widht: nil, height: 80)        
    }
    
    private func setupButtonConstraints() {
        self.view.addSubview(fromCurrencyButton)
        self.view.addSubview(toCurrencyButton)
        
        fromCurrencyButton.addAnchor(top: self.amountInputTextField.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 30, left: -20, bottom: 0, right: 0), widht: self.view.frame.width * 0.4, height: 80)
        
        toCurrencyButton.addAnchor(top: self.amountInputTextField.bottomAnchor, leading: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: 30, left: 0, bottom: 0, right: -20), widht: self.view.frame.width * 0.4, height: 80)
    }
    
    private func setupTargetingLabelsConstraints() {
        self.view.addSubview(fromCurrencyLabel)
        self.view.addSubview(toCurrencyLabel)
        
        fromCurrencyLabel.addAnchor(top: self.fromCurrencyButton.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 20, left: -20, bottom: 0, right: 0), widht: self.view.frame.width * 0.4, height: 40)
        
        toCurrencyLabel.addAnchor(top: self.toCurrencyButton.bottomAnchor, leading: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: 20, left: 0, bottom: 0, right: -20), widht: self.view.frame.width * 0.4, height: 40)
    }
    
    @objc func amountToBeConvertedDidChange() {
        guard let newAmount = amountInputTextField.text, newAmount != viewModel.fromCurrencyValue else {
            return
        }
        viewModel.fromCurrencyValue = newAmount
    }
}

extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    func updateUI() {
        resultCurrencyLabel.text = viewModel.toCurrencyValue
        fromCurrencyButton.setTitle(viewModel.fromCurrencyCode, for: .normal)
        toCurrencyButton.setTitle(viewModel.toCurrencyCode, for: .normal)
    }
    
    func shouldShowLoading(_ isLoading: Bool) {
        print("OI")
    }
    
    func showError(_ error: String) {
        print("OI")
    }
}
