//
//  ExchangeView.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class ExchangeView: UIView{
    
    lazy var valueTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Value"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.returnKeyType = .default
        textField.backgroundColor = .white
        textField.textColor = .black
        
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = self.frame.height * 0.02
        textField.layer.borderColor = UIColor.blue.cgColor
        
        textField.inputAccessoryView = doneToolbar
        
        return textField
    }()
    
    lazy var resultTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Result"
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        textField.backgroundColor = .white
        textField.textColor = .black
        
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = self.frame.height * 0.02
        textField.layer.borderColor = UIColor.blue.cgColor
        return textField
    }()
    
    lazy var firstCurrencyButton: UIButton = {
        var button = UIButton()
        button.setTitle("USD", for: .normal)
        button.tag = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        
        button.layer.borderWidth = 2
        button.layer.cornerRadius = self.frame.height * 0.02
        button.layer.borderColor = UIColor.blue.cgColor
        
        return button
    }()
    
    lazy var secondCurrencyButton: UIButton = {
        var button = UIButton()
        button.setTitle("BRL", for: .normal)
        button.tag = 2
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        
        button.layer.borderWidth = 2
        button.layer.cornerRadius = self.frame.height * 0.02
        button.layer.borderColor = UIColor.blue.cgColor

        return button
    }()
    
    lazy var simpleLabel: UILabel = {
        var label = UILabel()
        label.text = "TO"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var doneToolbar: UIToolbar = {
        var toolBar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        toolBar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        toolBar.items = items
        toolBar.sizeToFit()
        
        return toolBar
    }()

    @objc func doneButtonAction(){
        valueTextField.resignFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExchangeView: ViewCodable{
    
    func setupViewHierarchy() {
        self.addSubview(valueTextField)
        self.addSubview(firstCurrencyButton)
        self.addSubview(secondCurrencyButton)
        self.addSubview(resultTextField)
        self.addSubview(simpleLabel)
    }
    
    func setupConstraints() {
        // Value Text Field Anchors
        valueTextField.anchor(left: self.leftAnchor, paddingLeft: 20)
        valueTextField.anchor(right: self.rightAnchor, paddingRight: 20)
        valueTextField.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: self.frame.height * 0.1)
        valueTextField.anchor(height: self.frame.height * 0.1)
        
        // First button Anchors
        firstCurrencyButton.anchor(left: self.leftAnchor, paddingLeft: 20)
        firstCurrencyButton.anchor(right: self.centerXAnchor, paddingRight: self.frame.width * 0.1)
        firstCurrencyButton.anchor(top: valueTextField.bottomAnchor, paddingTop: self.frame.height * 0.05)
        firstCurrencyButton.anchor(height: self.frame.height * 0.1)
        
        // Result Text Field Anchors
        secondCurrencyButton.anchor(left: self.centerXAnchor, paddingLeft: self.frame.width * 0.1)
        secondCurrencyButton.anchor(right: self.rightAnchor, paddingRight: 20)
        secondCurrencyButton.anchor(top: valueTextField.bottomAnchor, paddingTop: self.frame.height * 0.05)
        secondCurrencyButton.anchor(height: self.frame.height * 0.1)
        
        // Result Text Field Anchors
        resultTextField.anchor(left: self.leftAnchor, paddingLeft: 20)
        resultTextField.anchor(right: self.rightAnchor, paddingRight: 20)
        resultTextField.anchor(top: self.secondCurrencyButton.bottomAnchor, paddingTop: self.frame.height * 0.05)
        resultTextField.anchor(height: self.frame.height * 0.1)
        
        // Simple Label Anchors
        simpleLabel.anchor(left: firstCurrencyButton.rightAnchor, paddingLeft: self.frame.width * 0.01)
        simpleLabel.anchor(right: secondCurrencyButton.leftAnchor, paddingRight: self.frame.width * 0.01)
        simpleLabel.anchor(top: valueTextField.bottomAnchor, paddingTop: self.frame.height * 0.05)
        simpleLabel.anchor(bottom: resultTextField.topAnchor, paddingBottom: self.frame.height * 0.05)
        
    }
}
