//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

/// Identificar para o botão que foi clicado (moeda de origem ou destino)
enum CurrencyTypeButtonTag: Int {
    case sourceCurrency = 1
    case targetCurrency = 2
}

class CurrencyConverterView: UIView {
    // MARK: - Source Currency Elements
    let sourceCurrencyValueTextField =  MoneyTextField()
    
    private let sourceCurrencyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Moeda de origem"
        label.textAlignment = .center
        return label
    }()
    
    let sourceCurrencyTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("MOEDA", for: .normal)
        button.tag = CurrencyTypeButtonTag.sourceCurrency.rawValue
        return button
    }()
    
    private let sourceCurrencyItemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let targetCurrencyValueTextField = MoneyTextField()
    
    
    
    // MARK: Target Currency Elements
    private let targetCurrencyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Moeda de destino"
        label.textAlignment = .center
        return label
    }()
    
    let targetCurrencyTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("MOEDA", for: .normal)
        button.tag = CurrencyTypeButtonTag.targetCurrency.rawValue
        return button
    }()
    
    private let targetCurrencyItemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let conversionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Converter", for: .normal)
        return button
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - ViewCodable
extension CurrencyConverterView: ViewCodable {
    func setupHierarchy() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(sourceCurrencyTitleLabel)
        contentStackView.addArrangedSubview(sourceCurrencyItemsStackView)
        sourceCurrencyItemsStackView.addArrangedSubview(sourceCurrencyTypeButton)
        sourceCurrencyItemsStackView.addArrangedSubview(sourceCurrencyValueTextField)
        
        contentStackView.addArrangedSubview(targetCurrencyTitleLabel)
        contentStackView.addArrangedSubview(targetCurrencyItemsStackView)
        targetCurrencyItemsStackView.addArrangedSubview(targetCurrencyTypeButton)
        targetCurrencyItemsStackView.addArrangedSubview(targetCurrencyValueTextField)
        
        contentStackView.addArrangedSubview(conversionButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 50),
            contentStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            targetCurrencyTypeButton.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            sourceCurrencyTypeButton.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.25)
        ])
    }
    
    func setupAditionalConfiguration() {
        self.backgroundColor = .systemBackground
        self.targetCurrencyValueTextField.isEnabled = false
    }
}
