//
//  BTGCurrencyConverterView.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//


import UIKit


class BTGCurrencyConverterView: UIView {
    
    var fromLabel: UILabel  = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = lbl.font.withSize(15)
        lbl.text = "De:"
        lbl.textColor = .black
        return lbl
    }()
    
    var buttonFrom: BorderedButton = {
        let btn = BorderedButton()
        btn.setTitle("Toque para escolher", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    var toLabel: UILabel  = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = lbl.font.withSize(15)
        lbl.text = "Para:"
        lbl.textColor = .black
        return lbl
    }()
    
    var buttonTo: BorderedButton = {
        let btn = BorderedButton()
        btn.setTitle("Toque para escolher", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    var numberTextField: NumberTextField = {
        let textField = NumberTextField()
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.text = "1.00"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.isEnabled = false
        textField.isHidden = true
        return textField
    }()
    var currencyConverterLabel: UILabel  = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(32)
        lbl.textColor = .black
        return lbl
    }()
    

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupUI()
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


fileprivate extension BTGCurrencyConverterView {
    func setupUI() {
        self.backgroundColor = AppStyle.Color.background
    }
    
    func addViews() {
        self.addSubViews(views: [
            fromLabel,
            buttonFrom,
            toLabel,
            buttonTo,
            numberTextField,
            currencyConverterLabel
        ])
        
    }
    
    func addConstraints() {
        let layoutGuides = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            
            fromLabel.topAnchor.constraint(equalTo: layoutGuides.topAnchor),
            fromLabel.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            fromLabel.widthAnchor.constraint(equalToConstant: 50),
            
            buttonFrom.topAnchor.constraint(equalTo: layoutGuides.topAnchor),
            buttonFrom.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            buttonFrom.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor, constant: 10),
            buttonFrom.heightAnchor.constraint(equalToConstant: 45),
        
            toLabel.topAnchor.constraint(equalTo: buttonFrom.bottomAnchor, constant: 10),
            toLabel.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            toLabel.widthAnchor.constraint(equalToConstant: 50),
            
            buttonTo.topAnchor.constraint(equalTo: buttonFrom.bottomAnchor, constant: 10),
            buttonTo.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 10),
            buttonTo.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            buttonTo.heightAnchor.constraint(equalToConstant: 45),
            
            numberTextField.topAnchor.constraint(equalTo: buttonTo.bottomAnchor, constant: 10),
            numberTextField.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            numberTextField.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            numberTextField.heightAnchor.constraint(equalToConstant: 45),
            
            currencyConverterLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 10),
            currencyConverterLabel.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            currencyConverterLabel.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            currencyConverterLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
