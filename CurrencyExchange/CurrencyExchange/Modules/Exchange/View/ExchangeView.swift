//
//  ExchangeView.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit




class ExchangeView: UIView, ActivityIndicator {
    
    // MARK: - Properties
    
    private let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.00)
        return view
    }()
    
    private let resultValueOfExchangeBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    let resultValueOfExchangeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = .white
        return label
    }()
    
    let exchangeTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Informe o valor ..."
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray
        textField.keyboardType = .decimalPad
        textField.textColor = .white
        return textField
    }()
    
    let originCurrencyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Origem", for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    let destinationCurrencyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Destino", for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    let convertButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Converter", for: .normal)
        button.backgroundColor = .link
        return button
    }()
    
    var loadingIndicatorView: UIView?
    
    var activityIndicator: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupViews()
    }
    
    private func setupUI(){
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Codable Protocol

extension ExchangeView: ViewCodable {
    
    func setupViewHierarchy() {
        self.addSubview(backgroundView)
        self.backgroundView.addSubview(resultValueOfExchangeBackgroundView)
        self.resultValueOfExchangeBackgroundView.addSubview(resultValueOfExchangeLabel)
        self.backgroundView.addSubview(exchangeTextField)
        self.backgroundView.addSubview(originCurrencyButton)
        self.backgroundView.addSubview(destinationCurrencyButton)
        self.backgroundView.addSubview(convertButton)
    }
    
    func setupConstraints() {
        self.backgroundViewConstraints()
        self.resultValueOfExchangeBackgroundViewConstraints()
        self.resultValueOfExchangeLabelContraints()
        self.exchangeTextFieldConstraints()
        self.setupOriginCurrencyButton()
        self.setupDestinationCurrencyButton()
        self.setupConvertButtonConstraints()
    }
    
    private func backgroundViewConstraints(){
        self.backgroundView.anchor(width: ScreenSize.width * 0.8, height: ScreenSize.height * 0.5)
        self.backgroundView.centerX(in: self)
        self.backgroundView.centerY(in: self)
        self.backgroundView.layer.cornerRadius = ScreenSize.width * 0.05
    }
    
    private func resultValueOfExchangeBackgroundViewConstraints(){
        self.resultValueOfExchangeBackgroundView.anchor(width: ScreenSize.width * 0.6, height: ScreenSize.height * 0.16)
        self.resultValueOfExchangeBackgroundView.anchor(top: backgroundView.topAnchor, paddingTop: ScreenSize.height * 0.06)
        self.resultValueOfExchangeBackgroundView.centerX(in: self)
        self.resultValueOfExchangeBackgroundView.layer.cornerRadius = ScreenSize.width * 0.05
    }
    
    private func resultValueOfExchangeLabelContraints() {
        self.resultValueOfExchangeLabel.centerY(in: resultValueOfExchangeBackgroundView)
        self.resultValueOfExchangeLabel.anchor(left: resultValueOfExchangeBackgroundView.leftAnchor, paddingLeft: ScreenSize.width * 0.02)
        self.resultValueOfExchangeLabel.anchor(right: resultValueOfExchangeBackgroundView.rightAnchor, paddingRight: ScreenSize.width * 0.02)
    }
    
    private func exchangeTextFieldConstraints(){
        self.exchangeTextField.anchor(width: ScreenSize.width * 0.6, height: ScreenSize.height * 0.06)
        self.exchangeTextField.anchor(top: resultValueOfExchangeBackgroundView.bottomAnchor, paddingTop: ScreenSize.height * 0.03)
        
        self.exchangeTextField.centerX(in: self)
        self.exchangeTextField.layer.cornerRadius = ScreenSize.width * 0.03

    }
    
    private func setupOriginCurrencyButton(){
        originCurrencyButton.anchor(width: ScreenSize.width * 0.2, height: ScreenSize.width * 0.1)
        originCurrencyButton.anchor(top: exchangeTextField.bottomAnchor, paddingTop: ScreenSize.height * 0.03)
        originCurrencyButton.anchor(left: backgroundView.leftAnchor, paddingLeft: ScreenSize.width * 0.1)
        originCurrencyButton.layer.cornerRadius = ScreenSize.width * 0.03
    }
    
    private func setupDestinationCurrencyButton(){
        destinationCurrencyButton.anchor(width: ScreenSize.width * 0.2, height: ScreenSize.width * 0.1)
        destinationCurrencyButton.anchor(top: exchangeTextField.bottomAnchor, paddingTop: ScreenSize.height * 0.03)
        destinationCurrencyButton.anchor(right: backgroundView.rightAnchor, paddingRight: ScreenSize.width * 0.1)
        destinationCurrencyButton.layer.cornerRadius = ScreenSize.width * 0.03
    }
    
    private func setupConvertButtonConstraints(){
        convertButton.anchor(width: ScreenSize.width * 0.6, height: ScreenSize.height * 0.06)
        self.convertButton.anchor(top: destinationCurrencyButton.bottomAnchor, paddingTop: ScreenSize.height * 0.03)
        self.convertButton.centerX(in: self)
        self.convertButton.layer.cornerRadius = ScreenSize.width * 0.03
    }
    
    
}
