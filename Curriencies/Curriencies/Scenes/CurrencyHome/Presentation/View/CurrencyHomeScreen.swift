//
//  CurrencyHomeScreen.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

import UIKit

fileprivate enum Layout {
    static let containerHeight = UIScreen.main.bounds.height/3
    static let textsWidth = UIScreen.main.bounds.width/3 * 2 - 20
    static let buttonsWidth = UIScreen.main.bounds.width/3 - 10
    static let itensHeight = containerHeight/2 - 10
}

final class CurrencyHomeScreen: UIView {
    
    let defaultOriginButtonTitle: String = "USD"
    let defaultOriginTextFieldPlaceholder: String = "1.00"
    let defaultDestinationButtonTitle: String = "BRL"
    weak var homeActions: HomeActionsProtocol?
    
    private lazy var originCurrencyButton: UIButton = {
        let button = UIButton()
        button.setTitle(defaultOriginButtonTitle, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(originButtonAction),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var originCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = defaultOriginTextFieldPlaceholder
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self,
                            action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        
        return textField
    }()
    
    private lazy var destinationCurrencyButton: UIButton = {
        let button = UIButton()
        button.setTitle(defaultDestinationButtonTitle, for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(destinationButtonAction),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var destinationCurrencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Erro ao buscar moedas!!!", message: "tente novamente mais tarde :(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        return alert
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewConfiguration
extension CurrencyHomeScreen: ViewConfiguration {
    func buildHierarchy() {
        containerView.addSubviews(views: [
            originCurrencyButton,
            originCurrencyTextField,
            destinationCurrencyLabel,
            destinationCurrencyButton
        ])
        addSubview(containerView)
    }
    
    func makeConstraints() {
        containerView
            .make([.centerX, .width], equalTo: self)
            .make(.centerY, equalTo: self, constant: -70)
            .make(.height, equalTo: Layout.containerHeight)
        
        originCurrencyTextField
            .make(.leading, equalTo: self, constant: 10)
            .make(.top, equalTo: containerView)
            .make(.width, equalTo: Layout.textsWidth)
            .make(.height, equalTo: Layout.itensHeight)
        
        originCurrencyButton
            .make(.leading, equalTo: originCurrencyTextField, attribute: .trailing, constant: 10)
            .make([.top, .height], equalTo: originCurrencyTextField)
            .make(.width, equalTo: Layout.buttonsWidth)
        
        destinationCurrencyLabel
            .make([.leading, .width, .height], equalTo: originCurrencyTextField)
            .make(.bottom, equalTo: containerView)
        
        destinationCurrencyButton
            .make([.leading, .width, .height], equalTo: originCurrencyButton)
            .make(.bottom, equalTo: destinationCurrencyLabel)
    }
    
    func additionalConfigs() {
        backgroundColor = .white
    }
}

// MARK: - View Actions
@objc private extension CurrencyHomeScreen {
    func originButtonAction() {
        homeActions?.tapOriginButton()
    }
    
    func destinationButtonAction() {
        homeActions?.tapDestinationButton()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        homeActions?.valueDidChange(newValue: textField.text ?? "")
    }
}

// MARK: - View Methods
extension CurrencyHomeScreen {
    func updateLabelValue(_ value: String) {
        destinationCurrencyLabel.text = value
    }
    
    func errorHandling() {
        homeActions?.presentAlert(errorAlert)
        originCurrencyButton.isEnabled = false
        destinationCurrencyButton.isEnabled = false
    }
    
    func updateButtonTitle(_ title: String, newValue: String, type: CurrencyType) {
        if type == .origin {
            originCurrencyButton.setTitle(title, for: .normal)
        } else {
            destinationCurrencyButton.setTitle(title, for: .normal)
        }
        originCurrencyTextField.text = "1"
        destinationCurrencyLabel.text = newValue
    }
}
