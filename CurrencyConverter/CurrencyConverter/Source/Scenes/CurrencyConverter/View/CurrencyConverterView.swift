//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class CurrencyConverterView: BaseView {
    
    // MARK: - UI Components
    lazy var titleLabel = TitleLabel()
        .set(\.text, to: LocalizableStrings.currencyConverterViewTitle.localized)
    
    lazy var swapButton = UIButton()
        .set(\.tintColor, to: .black)
        .run {
            let icon = UIImage(systemName: "arrow.triangle.swap", withConfiguration: UIImage.SymbolConfiguration(weight: .thin))?.withRenderingMode(.alwaysTemplate)
            $0.setImage(icon, for: .normal)
        }
    
    lazy var fromCurrencySelectButton = CurrencySelectButton()
        .set(\.primaryLabel.text, to: LocalizableStrings.currencyConverterViewTapToSelect.localized)
        .set(\.secondaryLabel.text, to: "")
    
    lazy var fromValueTextField = UITextField()
        .set(\.textAlignment, to: .right)
        .set(\.font, to: UIFont.systemFont(ofSize: 24, weight: .light))
        .set(\.placeholder, to: LocalizableStrings.currencyConverterViewValuePlaceholder.localized)
        .set(\.keyboardType, to: .decimalPad)
        .set(\.borderStyle, to: .none)
        .run {
            let border = UIView().set(\.backgroundColor, to: .lightGray)
            $0.addSubview(border)
            border
                .anchor(bottom: $0.bottomAnchor)
                .anchor(left: $0.leftAnchor)
                .anchor(right: $0.rightAnchor)
                .anchor(heightConstant: 1)
        }
    
    lazy var equalsLabel = UILabel()
        .set(\.font, to: UIFont.systemFont(ofSize: 24, weight: .thin))
        .set(\.text, to: LocalizableStrings.generalEqualSign.localized)
    
    lazy var resultValueLabel = UILabel()
        .set(\.font, to: UIFont.systemFont(ofSize: 24, weight: .medium))
        .set(\.text, to: "0.00")
    
    lazy var toCurrencySelectButton = CurrencySelectButton()
        .set(\.primaryLabel.text, to: LocalizableStrings.currencyConverterViewTapToSelect.localized)
        .set(\.secondaryLabel.text, to: "")
    
    // MARK: - Setup
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(swapButton)
        
        addSubview(fromCurrencySelectButton)
        addSubview(fromValueTextField)
        
        addSubview(equalsLabel)
        
        addSubview(resultValueLabel)
        addSubview(toCurrencySelectButton)
    }
    
    override func autoLayout() {
        titleLabel
            .anchor(top: safeAreaLayoutGuide.topAnchor, padding: 24)
            .anchor(centerX: centerXAnchor)
    
        swapButton
            .anchor(top: safeAreaLayoutGuide.topAnchor, padding: 24)
            .anchor(right: rightAnchor, padding: 16)
        
        fromCurrencySelectButton
            .anchor(top: titleLabel.bottomAnchor, padding: 32)
            .anchor(leading: leadingAnchor, padding: 32)
            .anchor(trailing: trailingAnchor, padding: 32)
        
        fromValueTextField
            .anchor(top: fromCurrencySelectButton.bottomAnchor, padding: 24)
            .anchor(trailing: trailingAnchor, padding: 32)
            .anchor(widthConstant: 160)
        
        equalsLabel
            .anchor(top: fromValueTextField.bottomAnchor, padding: 12)
            .anchor(trailing: trailingAnchor, padding: 32)
        
        resultValueLabel
            .anchor(top: equalsLabel.bottomAnchor, padding: 12)
            .anchor(trailing: trailingAnchor, padding: 32)
        
        toCurrencySelectButton
            .anchor(top: resultValueLabel.bottomAnchor, padding: 24)
            .anchor(leading: leadingAnchor, padding: 32)
            .anchor(trailing: trailingAnchor, padding: 32)
    }
    
}
