//
//  CurrencyConvertionView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyConversionView: UIView {
    
    private unowned var firstCurrencyButton: CurrencyButton
    private unowned var secondCurrencyButton: CurrencyButton
    private unowned var convertActionButton: ConvertActionButton
    private unowned var resultLbl: UILabel
    private unowned var errorView: ErrorView
    private unowned var currencyTextField: UITextField
    
    private lazy var firstCurrencyLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var secondCurrencyLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var imageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var resultContainerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    init(frame: CGRect = .zero,
         firstCurrencyButton: CurrencyButton,
         secondCurrencyButton: CurrencyButton,
         convertActionButton: ConvertActionButton,
         resultLbl: UILabel,
         errorView: ErrorView,
         currencyTextField: UITextField) {
        self.firstCurrencyButton = firstCurrencyButton
        self.secondCurrencyButton = secondCurrencyButton
        self.convertActionButton = convertActionButton
        self.resultLbl = resultLbl
        self.errorView = errorView
        self.currencyTextField = currencyTextField
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

extension CurrencyConversionView: ViewCodeProtocol {
     
    func buildHierarchy() {
        resultContainerView.addSubview(resultLbl)
        addSubview(resultContainerView)
        addSubview(firstCurrencyButton)
        addSubview(firstCurrencyLbl)
        addSubview(secondCurrencyLbl)
        addSubview(secondCurrencyButton)
        addSubview(currencyTextField)
        addSubview(convertActionButton)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        firstCurrencyLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: firstCurrencyLbl,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 100).isActive = true
        NSLayoutConstraint(item: firstCurrencyLbl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        firstCurrencyLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstCurrencyLbl.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        firstCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: firstCurrencyButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: firstCurrencyLbl,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 5).isActive = true
        NSLayoutConstraint(item: firstCurrencyButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: firstCurrencyLbl,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        firstCurrencyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstCurrencyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        secondCurrencyLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: secondCurrencyLbl,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: firstCurrencyButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 15).isActive = true
        NSLayoutConstraint(item: secondCurrencyLbl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: firstCurrencyButton,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        secondCurrencyLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        secondCurrencyLbl.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        secondCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: secondCurrencyButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: secondCurrencyLbl,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 15).isActive = true
        NSLayoutConstraint(item: secondCurrencyButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: secondCurrencyLbl,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        secondCurrencyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        secondCurrencyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: currencyTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: secondCurrencyButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 30).isActive = true
        NSLayoutConstraint(item: currencyTextField,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: secondCurrencyButton,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        currencyTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        currencyTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        convertActionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: convertActionButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: currencyTextField,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 30).isActive = true
        NSLayoutConstraint(item: convertActionButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: currencyTextField,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        convertActionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        convertActionButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        resultContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: resultContainerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -60).isActive = true
        NSLayoutConstraint(item: resultContainerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0, constant: 0).isActive = true
        resultContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        resultContainerView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        
        resultLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: resultLbl,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: resultContainerView,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: resultLbl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: resultContainerView,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        resultLbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        resultLbl.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func configureViews() {
        firstCurrencyLbl.text = Constants.Labels.firstCurrencyLbl
        firstCurrencyLbl.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        firstCurrencyLbl.textColor = .yellow
        firstCurrencyLbl.textAlignment = .center

        secondCurrencyLbl.text = Constants.Labels.secondCurrencyLbl
        secondCurrencyLbl.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        secondCurrencyLbl.textColor = .yellow
        secondCurrencyLbl.textAlignment = .center
        
        currencyTextField.keyboardType = .decimalPad
        currencyTextField.layer.borderWidth = 2
        currencyTextField.layer.borderColor = UIColor.black.cgColor
        currencyTextField.layer.cornerRadius = 4
        currencyTextField.textAlignment = .center
        currencyTextField.backgroundColor = .currencyMainButtonBackgroundColor
        currencyTextField.textColor = .yellow
        currencyTextField.attributedPlaceholder = NSAttributedString(string: Constants.TextField.currencyTextFieldPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.convertButtonLayerColor])
        
        resultContainerView.layer.cornerRadius = 4
        resultContainerView.layer.borderWidth = 2
        resultContainerView.layer.borderColor = UIColor.currencyTableViewCellLayerColor.cgColor
        resultContainerView.backgroundColor = .clear
        
        
        resultLbl.textAlignment = .center
        resultLbl.textColor = .currencyTableViewCellLayerColor
        
        backgroundColor = .currencyTableViewCellBackgrouncColor
    }
}
