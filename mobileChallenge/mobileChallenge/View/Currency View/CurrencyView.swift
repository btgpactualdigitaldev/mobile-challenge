//
//  CurrencyView.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 22/11/20.
//

import Foundation
import UIKit

class CurrencyView: UIView{
    
    //MARK: -Variables
    lazy var convertButton: UIButton = {
       let convertBtn = UIButton()
        convertBtn.backgroundColor = UIColor(red: 100/255, green: 215/255, blue: 126/255, alpha: 1)
        convertBtn.setTitle("Converter", for: .normal)
        convertBtn.setTitleColor(UIColor(red: 8/255, green: 20/255, blue: 30/255, alpha: 1), for: .normal)
        convertBtn.layer.borderWidth = 0.3
        convertBtn.layer.borderColor = CGColor(red: 38/255, green: 52/255, blue: 68/255, alpha: 1)
        convertBtn.layer.cornerRadius = 5
        convertBtn.sizeToFit()
        return convertBtn
    }()
    
    lazy var firstCurrencyButton: UIButton = {
       let currencyBtn = UIButton()
        currencyBtn.backgroundColor = .purple
        currencyBtn.setTitle("Currency 1", for: .normal)
        currencyBtn.layer.borderWidth = 0.2
        currencyBtn.layer.borderColor = UIColor.lightGray.cgColor
        currencyBtn.layer.cornerRadius = 5
        currencyBtn.sizeToFit()
        return currencyBtn
    }()
    
    lazy var secondCurrencyButton: UIButton = {
       let currencyBtn = UIButton()
        currencyBtn.backgroundColor = .purple
        currencyBtn.setTitle("Currency 2", for: .normal)
        currencyBtn.layer.borderWidth = 0.2
        currencyBtn.layer.borderColor = UIColor.lightGray.cgColor
        currencyBtn.layer.cornerRadius = 5
        currencyBtn.sizeToFit()
        return currencyBtn
    }()
    
    lazy var inputValue: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.textAlignment = .right
        input.keyboardType = .decimalPad
        input.backgroundColor = .white
        input.attributedPlaceholder = NSAttributedString(string: "0",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        input.placeholder = "0"
        return input
    }()
    
    lazy var receiverValue: UILabel = {
        let receiverLabel = UILabel()
        receiverLabel.backgroundColor = .white
        receiverLabel.textAlignment = .right
        receiverLabel.layer.borderWidth = 0.2
        receiverLabel.layer.borderColor = UIColor.lightGray.cgColor
        receiverLabel.layer.cornerRadius = 5
        receiverLabel.layer.masksToBounds = true
        return receiverLabel
    }()
    
    lazy var stackFirstButton: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstCurrencyButton,inputValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var stackSecondButton: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondCurrencyButton,receiverValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    //MARK: -Init
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.setupView()
        self.setupButtons()
    }
    
    //MARK: -Required Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    func setupView(){
        self.backgroundColor = UIColor(red: 8/255, green: 20/255, blue: 30/255, alpha: 1)
    }
    
    func simpleAlert(viewController:UIViewController,_ titleController: String,_ messageController:String,_ titleAlert:String){
        let alert = UIAlertAction(title: titleAlert, style: .default) { (UIAlertAction) in
            
        }
        let alertController = UIAlertController(title: titleController, message: messageController, preferredStyle: .alert)
        alertController.addAction(alert)
        
        viewController.present(alertController, animated: false, completion: nil)
    }
    
    func setupButtons(){
        self.stackFirstButton.translatesAutoresizingMaskIntoConstraints = false
        self.stackSecondButton.translatesAutoresizingMaskIntoConstraints = false
        self.convertButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackFirstButton)
        addSubview(stackSecondButton)
        addSubview(convertButton)
        
        NSLayoutConstraint.activate([
            //first stack
            self.stackFirstButton.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor),
            self.stackFirstButton.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor),
            self.stackFirstButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
            self.stackFirstButton.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            
            //second stack
            self.stackSecondButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
            self.stackSecondButton.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            self.stackSecondButton.topAnchor.constraint(equalTo:  self.stackFirstButton.layoutMarginsGuide.bottomAnchor, constant: 20),
            
            //convert button
            self.convertButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
            self.convertButton.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            self.convertButton.topAnchor.constraint(equalTo:  self.stackSecondButton.layoutMarginsGuide.bottomAnchor, constant: 20)
        ])
    }
}

//MARK: -Extensions
extension CurrencyView:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.inputValue.isUserInteractionEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.inputValue.isUserInteractionEnabled = false
    }
}
