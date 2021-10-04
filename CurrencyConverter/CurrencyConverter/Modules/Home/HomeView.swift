//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

final class HomeView: UIView {
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(32)
        lbl.text = "Currency Converter"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var currencyTitle: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(14)
        lbl.text = "From:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var currencyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("BRL: Brazilian Real", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var newCurrencyTitle: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(14)
        lbl.text = "To:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var newCurrencyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("USD: United States Dollar", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var equalTitle: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(14)
        lbl.text = "Is equal to:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var newCurrencySufix: UILabel = {
        let lbl = UILabel()
        lbl.text = "USD  "
        lbl.sizeToFit()
        lbl.textAlignment = .natural
        return lbl
    }()
    
    lazy var newCurrencyLabel: UITextField = {
        let textField = UITextField()
        textField.rightView = newCurrencySufix
        textField.leftView = newCurrencyPrefix
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.text = "0.00"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    lazy var currencySufix: UILabel = {
        let lbl = UILabel()
        lbl.text = "BRL  "
        lbl.sizeToFit()
        lbl.textAlignment = .natural
        return lbl
    }()
    
    lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0.00"
        textField.rightView = currencySufix
        textField.leftView = currencyPrefix
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var currencyPrefix: UILabel = {
        let lbl = UILabel()
        lbl.text = "  $"
        lbl.sizeToFit()
        lbl.textAlignment = .natural
        return lbl
    }()
    
    lazy var newCurrencyPrefix: UILabel = {
        let lbl = UILabel()
        lbl.text = "  $"
        lbl.sizeToFit()
        lbl.textAlignment = .natural
        return lbl
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Configurate Moethods
extension HomeView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([titleLabel, currencyTitle, currencyButton, newCurrencyTitle, newCurrencyButton, equalTitle, currencyTextField, newCurrencyLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 96),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            currencyTitle.bottomAnchor.constraint(equalTo: currencyButton.topAnchor, constant: -4),
            currencyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),

            currencyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            currencyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            currencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            newCurrencyTitle.bottomAnchor.constraint(equalTo: newCurrencyButton.topAnchor, constant: -4),
            newCurrencyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),

            newCurrencyButton.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: 20),
            newCurrencyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            newCurrencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            currencyTextField.topAnchor.constraint(equalTo: newCurrencyButton.bottomAnchor, constant: 32),
            currencyTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            currencyTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            currencyTextField.heightAnchor.constraint(equalTo: currencyButton.heightAnchor),
            
            equalTitle.bottomAnchor.constraint(equalTo: newCurrencyLabel.topAnchor, constant: -4),
            equalTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            newCurrencyLabel.topAnchor.constraint(equalTo: currencyTextField.bottomAnchor, constant: 20),
            newCurrencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            newCurrencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            newCurrencyLabel.heightAnchor.constraint(equalTo: currencyButton.heightAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
    }
    
}
