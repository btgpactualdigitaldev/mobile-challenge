//
//  ConvertionView.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class ConversionView: UIView {
	private let stackToButtons = UIStackView()
	private let fromCurrencyCell = CurrencySectionView()
	private let toCurrencyCell = CurrencySectionView()
	
	private let fromCurrencyGesture = UITapGestureRecognizer(target: self, action:  #selector(fromCurrencyOnTap))
	private let toCurrencyGesture = UITapGestureRecognizer(target: self, action:  #selector(toCurrencyOnTap))

	var fromOnClick: (() -> Void)?
	var toOnClick: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI() {
		addSubview(stackToButtons)
		stackToButtons.addArrangedSubview(fromCurrencyCell)
		stackToButtons.addArrangedSubview(toCurrencyCell)
		
		fromCurrencyCell.addGestureRecognizer(fromCurrencyGesture)
		toCurrencyCell.addGestureRecognizer(toCurrencyGesture)
		
		stackToButtons.alignment = .center
		stackToButtons.axis = .vertical
		stackToButtons.distribution = .fillEqually
		stackToButtons.spacing = 10
		
		stackToButtons.anchor(
			top: (topAnchor, 0),
			right: (rightAnchor, 0),
			left: (leftAnchor, 0)
		)
	}
	
	@objc private func fromCurrencyOnTap() {
		fromOnClick?()
	}
	
	@objc private func toCurrencyOnTap() {
		toOnClick?()
	}
}

class CurrencySectionView: UIView {
	let titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	let clickHereView: UIView = {
		let view = UIView()
		return view
	}()
	let currencyView: UIView = {
		let view = UIView()
		return view
	}()
	let codeLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	let valueLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	convenience init() {
		self.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(titleLabel)
		addSubview(clickHereView)
		addSubview(currencyView)
		currencyView.addSubview(codeLabel)
		currencyView.addSubview(valueLabel)
	}
	
	private func setupConstraints() {
		titleLabel.anchor(
			top: (topAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20)
		)
		
		clickHereView.anchor(
			top: (titleLabel.bottomAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (bottomAnchor, 20)
		)
		
		currencyView.anchor(
			top: (titleLabel.bottomAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (bottomAnchor, 20)
		)
		
		codeLabel.anchor(
			top: (currencyView.bottomAnchor, 0),
			right: (currencyView.rightAnchor, 0),
			bottom: (currencyView.bottomAnchor, 0)
		)
		
		valueLabel.anchor(
			top: (currencyView.bottomAnchor, 0),
			left: (currencyView.leftAnchor, 0),
			bottom: (currencyView.bottomAnchor, 0)
		)
	}
}
