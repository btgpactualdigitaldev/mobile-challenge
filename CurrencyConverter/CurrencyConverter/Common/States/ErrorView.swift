//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 01/11/20.
//

import UIKit

class ErrorView: UIView {
    
    var text: String? {
        get { errorLabel.text }
        set { errorLabel.text = newValue }
    }
    
    lazy var retry: (() -> Void)? = nil
    
    // MARK: - Layout Vars
    private lazy var errorLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = Style.highlightFont
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        button.setTitle("Try Again", for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(text: String, retry: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.retry = retry
        errorLabel.text = text
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        backgroundColor = .black
        addSubview(errorLabel)
        
        errorLabel
            .centerY(centerYAnchor, constant: -Style.defaultSpace)
            .leading(anchor: leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: trailingAnchor, constant: Style.defaultTrailing)
        
        guard retry != nil else { return }
        addSubview(retryButton)
        retryButton
            .top(anchor: errorLabel.bottomAnchor, constant: Style.defaultTop)
            .centerX(centerXAnchor)
            .width(anchor: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
            .height(constant: Style.Home.currencyHeight)
    }
    
    // MARK: - Actions
    @objc private func tryAgain() {
        retry?()
    }
}
