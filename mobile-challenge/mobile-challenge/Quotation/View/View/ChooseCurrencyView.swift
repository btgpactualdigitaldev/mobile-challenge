//
//  ChooseCurrencyView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 26/11/20.
//

import UIKit

class ChooseCurrencyView : UIView {
    private var topStack: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .firstBaseline
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var bottomStack: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .firstBaseline
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
        
    var originCurrencyButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("---", for: .normal)
        let textColor = QuotationColors.buttonTextColor.color
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = QuotationColors.currencyButton.color
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        button.tintColor = textColor
        button.semanticContentAttribute = .forceRightToLeft
        button.tag = TagButton.origin.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textValueToConvert: UITextField = {
        var text = UITextField(frame: .zero)
        text.placeholder = "0.00"
        text.font = UIFont.systemFont(ofSize: 20)
        text.textAlignment = .right
        text.backgroundColor = QuotationColors.textFiledBackground.color
        text.borderStyle = .roundedRect
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private var convertIndicator: UIImageView = {
        let image = UIImageView(frame: .zero)
        let img = UIImage(systemName: "arrow.down", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        image.image = img
        image.tintColor = QuotationColors.topBackground.color
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var destinyCurrencyButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("---", for: .normal)
        let textColor = QuotationColors.buttonTextColor.color
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = QuotationColors.currencyButton.color
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        button.tintColor = textColor
        button.semanticContentAttribute = .forceRightToLeft
        button.tag = TagButton.destiny.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var resultLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = QuotationColors.resultLabel.color
        label.textAlignment = .right
        label.text = "0.00"
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonHeight: CGFloat {
        return 50
    }
    
    var buttonWidth: CGFloat {
        return 100
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseCurrencyView: ViewCodable {
    func setUpHierarchy() {
        addSubview(topStack)
        addSubview(convertIndicator)
        addSubview(bottomStack)
        
        topStack.addArrangedSubview(originCurrencyButton)
        topStack.addArrangedSubview(textValueToConvert)
        
        bottomStack.addArrangedSubview(destinyCurrencyButton)
        bottomStack.addArrangedSubview(resultLabel)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            convertIndicator.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 12),
            convertIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            convertIndicator.heightAnchor.constraint(equalToConstant: 20),
            convertIndicator.widthAnchor.constraint(equalToConstant: 20),
            
            bottomStack.topAnchor.constraint(equalTo: convertIndicator.bottomAnchor, constant: 5),
            bottomStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            destinyCurrencyButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            destinyCurrencyButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            originCurrencyButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            originCurrencyButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            textValueToConvert.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            resultLabel.centerYAnchor.constraint(equalTo: bottomStack.centerYAnchor)
            
        ])
    }
    
    func setUpAditionalConfiguration() {
        roundView(view: originCurrencyButton)
        roundView(view: destinyCurrencyButton)
    }
    
    func roundView(view: UIView) {
        view.layer.cornerRadius = 5
    }
}
