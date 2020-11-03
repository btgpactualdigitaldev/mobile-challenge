//
//  EmptyCurrencyView.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 01/11/20.
//

import UIKit

protocol EmptyCurrencyViewDelegate: class {
    func didClickToOpenList(type: CurrencyType)
}

class EmptyCurrencyView: UIView {
    
    weak var delegate: EmptyCurrencyViewDelegate?
    
    // MARK: - Layout Vars
    private lazy var originDescription: UILabel = {
        let label = UILabel().useConstraint()
        label.numberOfLines = 0
        label.font = Style.defaultFont
        label.textColor = Style.defaultPrimaryTextColor
        label.textAlignment = .center
        label.text = "To start you will need to choose a currency to input the value"
        return label
    }()
    
    private lazy var originCurrencyButton: UIButton = {
        let attibutes: [NSAttributedString.Key: Any] = [.font: Style.defaultFont, .foregroundColor: UIColor.white]
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(originList), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string: "Input Currency", attributes: attibutes), for: .normal)
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        return button
    }()
    
    private lazy var targetDescription: UILabel = {
        let label = UILabel().useConstraint()
        label.numberOfLines = 0
        label.font = Style.defaultFont
        label.textColor = Style.defaultPrimaryTextColor
        label.textAlignment = .center
        label.text = "and then you need to choose a target currency for the conversion"
        return label
    }()
    
    private lazy var targetCurrencyButton: UIButton = {
        let attibutes: [NSAttributedString.Key: Any] = [.font: Style.defaultFont, .foregroundColor: UIColor.white]
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(targetList), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string: "Target Currency", attributes: attibutes), for: .normal)
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        backgroundColor = .black
        addSubview(originDescription)
        addSubview(originCurrencyButton)
        addSubview(targetDescription)
        addSubview(targetCurrencyButton)
        
        originDescription
            .top(anchor: topAnchor, constant: Style.defaultTop)
            .leading(anchor: leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: trailingAnchor, constant: Style.defaultTrailing)
        
        originCurrencyButton
            .top(anchor: originDescription.bottomAnchor, constant: Style.defaultTop)
            .centerX(centerXAnchor)
            .height(constant: Style.Home.currencyHeight)
            .width(anchor: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
        
        targetDescription
            .top(anchor: originCurrencyButton.bottomAnchor, constant: Style.defaultTop)
            .leading(anchor: leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: trailingAnchor, constant: Style.defaultTrailing)
        
        targetCurrencyButton
            .top(anchor: targetDescription.bottomAnchor, constant: Style.defaultTop)
            .centerX(centerXAnchor)
            .height(constant: Style.Home.currencyHeight)
            .width(anchor: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
    }
    
    func setupCurrency(_ currency: Currecy, type: CurrencyType, title: NSMutableAttributedString) {
        switch type {
        case .origin:
            originCurrencyButton.setAttributedTitle(title, for: .normal)
        case .target:
            targetCurrencyButton.setAttributedTitle(title, for: .normal)
        }
    }
    
    // MARK: - Actions
    @objc private func originList() {
        delegate?.didClickToOpenList(type: .origin)
    }
    
    @objc private func targetList() {
        delegate?.didClickToOpenList(type: .target)
    }
}
