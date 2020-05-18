//
//  CoinConvertView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit
import SnapKit

class CoinConvertView: UIView {

    // MARK: - Constants
    
    static let containerViewMargin: CGFloat = 15
    static let containerViewPadding: CGFloat = 20
    static let coinsStackViewSpacing: CGFloat = 32
    static let convertButtonHeight: CGFloat = 60
    static let convertButtonTitle = "Convert"
    static let fromCoinTitle = "You are converting from"
    static let toCoinTitle = "You will receive"
    
    // MARK: - Properties
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 6
        
        // Border
        view.layer.borderColor = UIColor.elevationGray.cgColor
        view.layer.borderWidth = 1.0
        
        // Shadow
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.elevationGray.cgColor
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var coinsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = CoinConvertView.coinsStackViewSpacing
        return stackView
    }()
    
    lazy var fromCoinView: CoinView = {
        let view = CoinView(coinType: .from)
        view.coinButton.coinTypeLabel.text = "BRL"
        view.titleLabel.text = CoinConvertView.fromCoinTitle
        view.delegate = viewController
        return view
    }()
    
    lazy var toCoinView: CoinView = {
        let view = CoinView(coinType: .to)
        view.coinButton.coinTypeLabel.text = "USD"
        view.titleLabel.text = CoinConvertView.toCoinTitle
        view.valueTextField.isUserInteractionEnabled = false
        view.delegate = viewController
        return view
    }()
    
    lazy var convertButton: BtgButton = {
        let button = BtgButton()
        button.delegate = viewController
        button.setTitle(CoinConvertView.convertButtonTitle, for: .normal)
        return button
    }()
    
    weak var viewController: CoinConvertViewController?
    
    init(viewController: CoinConvertViewController) {
        self.viewController = viewController
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - View Coded
extension CoinConvertView: ViewCoded {
    func setupViewHierarhy() {
        addSubview(containerView)
        
        containerView.addSubview(coinsStackView)
        containerView.addSubview(convertButton)
        
        coinsStackView.addArrangedSubview(fromCoinView)
        coinsStackView.addArrangedSubview(toCoinView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).inset(CoinConvertView.containerViewMargin)
            make.bottom.equalTo(snp.bottom).inset(CoinConvertView.containerViewMargin)
            make.leading.equalTo(snp.leading).inset(CoinConvertView.containerViewMargin)
            make.trailing.equalTo(snp.trailing).inset(CoinConvertView.containerViewMargin)
        }
        
        coinsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).inset(CoinConvertView.containerViewPadding)
            make.leading.equalTo(containerView.snp.leading).inset(CoinConvertView.containerViewPadding)
            make.trailing.equalTo(containerView.snp.trailing).inset(CoinConvertView.containerViewPadding)
            make.height.equalTo(0).priority(.low)
        }
        
        convertButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.bottom).inset(CoinConvertView.containerViewPadding)
            make.leading.equalTo(containerView.snp.leading).inset(CoinConvertView.containerViewPadding)
            make.trailing.equalTo(containerView.snp.trailing).inset(CoinConvertView.containerViewPadding)
            make.height.equalTo(CoinConvertView.convertButtonHeight)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.lightGray
    }
}
