//
//  ViewController.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 02/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

protocol CurrencyExchangeViewControllerDelegate {
    func didSelectCurrency(_ currency: Currency, button: SelectedButton)
}

class CurrencyExchangeViewController: UIViewController {
    //MARK: Attributes
    let textLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Preencha o valor a ser convertido:"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let actualValueTextField: UITextField = {
        let lb = UITextField()
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.keyboardType = .numbersAndPunctuation
        lb.textAlignment = .center
        lb.autocorrectionType = .no
        lb.placeholder = "Insira o valor inicial"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let actualCurrencyLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Moeda origem:"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let actualCurrencyButton: CurrencyButton = {
        let lb = CurrencyButton(title: "Selecione", height: 40)
        lb.tag = SelectedButton.actualCurrency.rawValue
        return lb
    }()
    
    let currencyToExchangeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Moeda Destino:"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let currencyToExchangeButton: CurrencyButton = {
        let lb = CurrencyButton(title: "Selecione", height: 40)
        lb.tag = SelectedButton.currencyToExchange.rawValue
        return lb
    }()
    
    let convertedValueTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Valor convertido:"
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let convertedValueLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let calculateButton: CurrencyButton = {
        let lb = CurrencyButton(title: "Calcular")    
        lb.disable()
        return lb
    }()
    
    var viewModel: CurrencyExchangeViewModel
    
    //MARK: View LifeCycle
    init() {
        self.viewModel = CurrencyExchangeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Conversor de moeda"
        
        setupConstraints()
        setupDelegatesAndButtonTargets()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: Functions
    fileprivate func setupConstraints() {
        self.view.addSubview(textLabel)
        self.view.addSubview(actualValueTextField)
        self.view.addSubview(actualCurrencyLabel)
        self.view.addSubview(actualCurrencyButton)
        self.view.addSubview(currencyToExchangeLabel)
        self.view.addSubview(currencyToExchangeButton)
        self.view.addSubview(convertedValueLabel)
        self.view.addSubview(convertedValueTitleLabel)
        self.view.addSubview(convertedValueLabel)
        self.view.addSubview(calculateButton)
        
        textLabel.topAnchor.anchor(self.view.topAnchor, 20)
        textLabel.centerXAnchor.anchor(self.view.centerXAnchor)
        
        actualValueTextField.topAnchor.anchor(textLabel.bottomAnchor, 20)
        actualValueTextField.leftAnchor.anchor(self.view.leftAnchor, 8)
        actualValueTextField.rightAnchor.anchor(self.view.rightAnchor, -8)
        
        actualCurrencyLabel.leftAnchor.anchor(self.view.leftAnchor, 8)
        actualCurrencyLabel.centerYAnchor.anchor(self.view.centerYAnchor)
        
        actualCurrencyButton.leftAnchor.anchor(actualCurrencyLabel.rightAnchor, 20)
        actualCurrencyButton.rightAnchor.anchor(self.view.rightAnchor, -8)
        actualCurrencyButton.topAnchor.anchor(actualCurrencyLabel.topAnchor)
        actualCurrencyButton.bottomAnchor.anchor(actualCurrencyLabel.bottomAnchor)
        actualCurrencyButton.widthAnchor.anchor(self.view.frame.width * 0.3)
        
        currencyToExchangeLabel.leftAnchor.anchor(actualCurrencyLabel.leftAnchor)
        currencyToExchangeLabel.topAnchor.anchor(actualCurrencyLabel.bottomAnchor, 8)
        
        currencyToExchangeButton.leftAnchor.anchor(currencyToExchangeLabel.rightAnchor, 20)
        currencyToExchangeButton.rightAnchor.anchor(self.view.rightAnchor, -8)
        currencyToExchangeButton.topAnchor.anchor(currencyToExchangeLabel.topAnchor)
        currencyToExchangeButton.bottomAnchor.anchor(currencyToExchangeLabel.bottomAnchor)
        currencyToExchangeButton.widthAnchor.anchor(self.view.frame.width * 0.3)
        
        convertedValueTitleLabel.topAnchor.anchor(currencyToExchangeButton.bottomAnchor, 20)
        convertedValueTitleLabel.rightAnchor.anchor(self.view.rightAnchor, -8)
        convertedValueTitleLabel.leftAnchor.anchor(self.view.leftAnchor, 8)
        
        convertedValueLabel.topAnchor.anchor(convertedValueTitleLabel.bottomAnchor, 20)
        convertedValueLabel.rightAnchor.anchor(convertedValueTitleLabel.rightAnchor)
        convertedValueLabel.leftAnchor.anchor(convertedValueTitleLabel.leftAnchor)
        
        calculateButton.leftAnchor.anchor(self.view.leftAnchor, 20)
        calculateButton.rightAnchor.anchor(self.view.rightAnchor, -20)
        calculateButton.bottomAnchor.anchor(self.view.bottomAnchor, -20)
    }
    
    fileprivate func setupDelegatesAndButtonTargets() {
        actualValueTextField.delegate = self
        
        self.actualCurrencyButton.addTarget(self, action: #selector(selectCurrency(sender:)), for: .touchUpInside)
        self.currencyToExchangeButton.addTarget(self, action: #selector(selectCurrency(sender:)), for: .touchUpInside)
        self.calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
    }
    
    @objc fileprivate func selectCurrency(sender: UIButton) {
        guard let selectedButton = SelectedButton(rawValue: sender.tag) else { return }
        
        let vm = CurrencyListViewModel(selectedButton: selectedButton)
        let vc = CurrencyListViewController(vm, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func calculate() {
        showLoading {
            self.viewModel.calculate { [weak self] error in
                guard let wSelf = self else { return }
                wSelf.dismissLoading()
                
                if let error = error {
                    wSelf.showError(error)
                    return
                }
                
                DispatchQueue.main.async {
                    wSelf.convertedValueLabel.text = "\(self?.viewModel.selectedCurrency?.initials ?? ""): \(String(format: "%.2f", wSelf.viewModel.convertedCurrencyValue ?? 0.00))"
                }
            }
        }
    }
    
    fileprivate func validadeCalculateButton() {
        if viewModel.isValidToCalculate() {
            self.calculateButton.enable()
        } else {
            self.calculateButton.disable()
        }
    }
}

//MARK: Extensions
extension CurrencyExchangeViewController: CurrencyExchangeViewControllerDelegate {
    func didSelectCurrency(_ currency: Currency, button: SelectedButton) {
        
        switch button {
        case .actualCurrency:
            self.viewModel.setActualCurrency(currency)
            self.actualCurrencyButton.setTitle(self.viewModel.actualCurrency?.initials, for: .normal)
        case .currencyToExchange:
            self.viewModel.setSelectedCurrency(currency)
            self.currencyToExchangeButton.setTitle(self.viewModel.selectedCurrency?.initials, for: .normal)
        }
        
        validadeCalculateButton()
    }
}

extension CurrencyExchangeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.numericDigit() && string != "" { return false }
        var finalString = "\(textField.text!)\(string)"
        
        if string == "" {
            finalString.removeLast()
        }

        if finalString == "" {
            self.viewModel.actualCurrencyValue = nil
        } else {
            self.viewModel.actualCurrencyValue = Double(finalString) ?? 0
        }
        
        validadeCalculateButton()
        return true
    }
}
