//
//  CurrencyConversionViewController.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 24/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    // MARK: - Attributes
    let viewModel: CurrencyViewModel = CurrencyViewModel()
    
    // MARK: - Layout Attributes
    fileprivate let scrollView = UIScrollView()
    fileprivate let containerView = UIView()
    
    fileprivate let originCurrency: UILabel = {
        let lbl = UILabel()
        lbl.text = "Moeda a converter:"
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    fileprivate let selectOriginCurrencyBorder: UIView = {
        let vw = UIView()
        vw.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        vw.layer.borderWidth = 1
        return vw
    }()
    
    fileprivate let selectOriginCurrency: UILabel = {
        let lbl = UILabel()
        lbl.text = "Selecionar moeda"
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = UIColor.black.withAlphaComponent(0.2)
        return lbl
    }()
    
    fileprivate let targetCurrency: UILabel = {
        let lbl = UILabel()
        lbl.text = "Moeda desejada:"
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    fileprivate let selectTargetCurrencyBorder: UIView = {
        let vw = UIView()
        vw.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        vw.layer.borderWidth = 1
        return vw
    }()
    
    fileprivate let selectTargetCurrency: UILabel = {
        let lbl = UILabel()
        lbl.text = "Selecionar moeda"
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = UIColor.black.withAlphaComponent(0.2)
        return lbl
    }()
    
    fileprivate let originalCurrencyTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Valor original:"
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    fileprivate let originalCurrencyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Insira o valor a ser convertido"
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = UIColor.black.withAlphaComponent(0.6)
        return tf
    }()
    
    fileprivate let convertedCurrencyTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Valor convertido:"
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor.black
        lbl.isHidden = true
        return lbl
    }()
    
    fileprivate let convertedCurrencyValue: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = UIColor.black.withAlphaComponent(0.6)
        lbl.isHidden = true
        return lbl
    }()
    
    fileprivate let convertButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.backgroundColor = UIColor.lightGray.cgColor
        btn.clipsToBounds = true
        btn.setTitle("converter".uppercased(), for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "tela de conversão".uppercased()
        self.view.backgroundColor = UIColor.white
        setupConstraints()
        convertButton.addTarget(self, action: #selector(presentConvertedValue), for: .touchUpInside)
        originalCurrencyTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Layout Functions
    fileprivate func setupConstraints() {
        self.view.addSubview(convertButton)
        convertButton.anchor(
            left: (self.view.leftAnchor, 24),
            right: (self.view.rightAnchor, 24),
            bottom: (self.view.bottomAnchor, 24),
            height: 54
        )
        
        self.view.addSubview(scrollView)
        scrollView.anchor(
            top: (self.view.topAnchor, 0),
            left: (self.view.leftAnchor, 0),
            right: (self.view.rightAnchor, 0),
            bottom: (convertButton.topAnchor, 24)
        )
        
        scrollView.addSubview(containerView)
        containerView.anchor(
            top: (scrollView.topAnchor, 0),
            left: (self.view.leftAnchor, 24),
            right: (self.view.rightAnchor, 24),
            bottom: (scrollView.bottomAnchor, 0)
        )
        
        containerView.addSubview(originCurrency)
        originCurrency.anchor(
            top: (containerView.topAnchor, 24),
            left: (containerView.leftAnchor, 0)
        )
        
        containerView.addSubview(selectOriginCurrencyBorder)
        selectOriginCurrencyBorder.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToOriginCurrencySelection)))
        selectOriginCurrencyBorder.anchor(
            top: (originCurrency.bottomAnchor, 10),
            left: (containerView.leftAnchor, 0),
            right: (containerView.rightAnchor, 0),
            height: 40
        )
        
        selectOriginCurrencyBorder.addSubview(selectOriginCurrency)
        selectOriginCurrency.anchor(
            top: (selectOriginCurrencyBorder.topAnchor, 5),
            left: (selectOriginCurrencyBorder.leftAnchor, 5),
            right: (selectOriginCurrencyBorder.rightAnchor, 5),
            bottom: (selectOriginCurrencyBorder.bottomAnchor, 5)
        )
        
        containerView.addSubview(targetCurrency)
        targetCurrency.anchor(
            top: (selectOriginCurrencyBorder.bottomAnchor, 40),
            left: (containerView.leftAnchor, 0)
        )
        
        containerView.addSubview(selectTargetCurrencyBorder)
        selectTargetCurrencyBorder.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToTargetCurrencySelection)))
        selectTargetCurrencyBorder.anchor(
            top: (targetCurrency.bottomAnchor, 10),
            left: (containerView.leftAnchor, 0),
            right: (containerView.rightAnchor, 0),
            height: 40
        )
        
        selectTargetCurrencyBorder.addSubview(selectTargetCurrency)
        selectTargetCurrency.anchor(
            top: (selectTargetCurrencyBorder.topAnchor, 5),
            left: (selectTargetCurrencyBorder.leftAnchor, 5),
            right: (selectTargetCurrencyBorder.rightAnchor, 5),
            bottom: (selectTargetCurrencyBorder.bottomAnchor, 5)
        )
        
        containerView.addSubview(originalCurrencyTitle)
        originalCurrencyTitle.anchor(
            top: (selectTargetCurrencyBorder.bottomAnchor, 50),
            left: (containerView.leftAnchor, 0)
        )
        
        containerView.addSubview(originalCurrencyTextField)
        setupTextField()
        originalCurrencyTextField.anchor(
            top: (originalCurrencyTitle.bottomAnchor, 10),
            left: (containerView.leftAnchor, 0),
            right: (containerView.rightAnchor, 0)
        )
        
        containerView.addSubview(convertedCurrencyTitle)
        convertedCurrencyTitle.anchor(
            top: (originalCurrencyTextField.bottomAnchor, 40),
            left: (containerView.leftAnchor, 0)
        )
        
        containerView.addSubview(convertedCurrencyValue)
        convertedCurrencyValue.anchor(
            top: (convertedCurrencyTitle.bottomAnchor, 10),
            left: (containerView.leftAnchor, 0),
            right: (containerView.rightAnchor, 0),
            bottom: (containerView.bottomAnchor, 0)
        )
    }
    
    @objc fileprivate func presentConvertedValue() {
        if let text = originalCurrencyTextField.text, let amount = Double(text.removeFormat()) {
            viewModel.amount = amount
            viewModel.convertCurrencyValue() { text in
                DispatchQueue.main.async {
                    if let text = text {
                        self.convertedCurrencyTitle.isHidden = false
                        self.convertedCurrencyValue.isHidden = false
                        self.convertedCurrencyValue.text = text
                    } else {
                        self.presentAlertDialog(title: "Ops!", message: "Não foi possível converter o valor desejado agora, pedimos desculpa pelo transtorno!")
                    }
                }
            }
        } else {
            presentAlertDialog(title: "Opa!", message: "Por favor, insira um valor válido!")
        }
        
    }
    
    // MARK: - Navigation Functions
    @objc fileprivate func goToOriginCurrencySelection() {
        if let _ = viewModel.currencyList {
            let vc = CurrencyListViewController(viewModel: self.viewModel, currencyToBeSelect: .originalCurrency)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            viewModel.populateCurrencyList() {
                DispatchQueue.main.async {
                    if self.viewModel.currencyList == nil {
                        self.presentAlertDialog(title: "Ops!", message: "Não foi possível acessar a lista de moedas agora, pedimos desculpa pelo transtorno!")
                    } else {
                        let vc = CurrencyListViewController(viewModel: self.viewModel, currencyToBeSelect: .originalCurrency)
                        vc.delegate = self
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    @objc fileprivate func goToTargetCurrencySelection() {
        if let _ = viewModel.currencyList {
            let vc = CurrencyListViewController(viewModel: self.viewModel, currencyToBeSelect: .targetCurrency)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            viewModel.populateCurrencyList() {
                DispatchQueue.main.async {
                    if self.viewModel.currencyList == nil {
                        self.presentAlertDialog(title: "Ops!", message: "Não foi possível acessar a lista de moedas agora, pedimos desculpa pelo transtorno!")
                    } else {
                        let vc = CurrencyListViewController(viewModel: self.viewModel, currencyToBeSelect: .targetCurrency)
                        vc.delegate = self
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension CurrencyConversionViewController: UITextFieldDelegate {
    private func setupTextField() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okBtn = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(okButtonAction))
        
        toolbar.setItems([flexSpace, okBtn], animated: false)
        toolbar.sizeToFit()
        
        originalCurrencyTextField.inputAccessoryView = toolbar
    }
    
    @objc private func okButtonAction() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}

// MARK: - CurrencyListViewControllerDelegate
extension CurrencyConversionViewController: CurrencyListViewControllerDelegate {
    func selectCurrencyOnClick(currencyToBeSelect: CurrencyToBeSelect, currency: Currency) {
        DispatchQueue.main.async {
            switch currencyToBeSelect {
            case .originalCurrency:
                self.selectOriginCurrency.text = "\(currency.symbol) – \(currency.name)"
                self.selectOriginCurrency.textColor = UIColor.black.withAlphaComponent(0.6)
                self.viewModel.selectedOriginCurrencySymbol = currency.symbol
                
            case .targetCurrency:
                self.selectTargetCurrency.text = "\(currency.symbol) – \(currency.name)"
                self.selectTargetCurrency.textColor = UIColor.black.withAlphaComponent(0.6)
                self.viewModel.selectedTargetCurrencySymbol = currency.symbol
            }
            
            self.convertButton.isEnabled = self.viewModel.enableConvertButton()
            self.setButtonColor()
        }
    }
    
    public func setButtonColor() {
        convertButton.layer.backgroundColor = convertButton.isEnabled ? UIColor.systemBlue.cgColor : UIColor.lightGray.cgColor
    }
}

// MARK: UIAlertController
extension CurrencyConversionViewController {
    fileprivate func presentAlertDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
