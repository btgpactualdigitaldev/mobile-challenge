//
//  CoinView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

enum CoinType {
    case from
    case to // swiftlint:disable:this identifier_name
}

protocol CoinViewDelegate: class {
    func didUpdateCurrency(view: CoinView, value: String)
    func didTapCoinButton(view: CoinView)
}

class CoinView: UIView {

    // MARK: - Constants
    
    static let height: CGFloat = 52
    static let maxDigits: Int = 10
    
    // MARK: - Properties
    
    lazy var titleLabel: BtgLabel = {
        let label = BtgLabel()
        return label
    }()
    
    lazy var coinButton: BtgCoinButton = {
        let button = BtgCoinButton()
        button.delegate = self
        return button
    }()
    
    lazy var valueTextField: BtgTextField = {
        let label = BtgTextField()
        label.text = "0.00"
        label.textColor = coinType == .from ? UIColor.softBlue : UIColor.softGreen
        return label
    }()
    
    let coinType: CoinType
    var valueTypedString = ""
    weak var delegate: CoinViewDelegate?
    
    // MARK: - View Lyfe Cycle
    
    init(coinType: CoinType) {
        self.coinType = coinType
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.coinType = .from
        super.init(coder: coder)
    }
    
    func updateValue(value: String) {
        valueTextField.text = value
    }
    
    func updateNickname(nickname: String) {
        coinButton.coinTypeLabel.text = nickname
    }
}

// MARK: - View Coded
extension CoinView: ViewCoded {
    func setupViewHierarhy() {
        addSubview(titleLabel)
        addSubview(coinButton)
        addSubview(valueTextField)
    }
    
    func setupConstraints() {
        snp.makeConstraints { (make) in
            make.height.equalTo(CoinView.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        coinButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        valueTextField.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        valueTextField.delegate = self
    }
}

extension CoinView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String
    ) -> Bool {
        if string.count > 0 {
            if valueTypedString.count > CoinView.maxDigits {
                return false
            }
            
            valueTypedString += string
        } else {
            valueTypedString = String(valueTypedString.dropLast())
        }
        
        textField.text = valueTypedString.count > 0 ?
            BtgCurrencyFormatter.format(string: valueTypedString) : "0.00"
        
        delegate?.didUpdateCurrency(view: self, value: textField.text ?? "0.00")
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        valueTypedString = ""
        return true
    }
}

extension CoinView: BtgCoinButtonDelegate {
    func didTapCoinButton(view: BtgCoinButton) {
        delegate?.didTapCoinButton(view: self)
    }
}
