//
//  ConvertionView.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class ConversionView: UIView {

	private let stackToButtons = UIStackView()
	private let slider = UISlider()
	private let fromCurrencyCell = CurrencySectionView(title: AppStrings.shared.fromCurrencCellTitle)
	private let toCurrencyCell = CurrencySectionView(title: AppStrings.shared.toCurrencCellTitle)

	var fromOnClick: (() -> Void)?
	var toOnClick: (() -> Void)?
	var wasSlided: (() -> Void)?
	var slidePosition: Float = 0
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI() {
		addSubview(stackToButtons)
		addSubview(slider)
		stackToButtons.addArrangedSubview(fromCurrencyCell)
		stackToButtons.addArrangedSubview(toCurrencyCell)
		self.backgroundColor = UIColor(red: 1 / 255, green: 0, blue: 103/255, alpha: 1)
		
		slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
		slider.tintColor = .gray
		let fromCurrencyGesture = UITapGestureRecognizer(target: self, action:  #selector(fromCurrencyOnTap))
		let toCurrencyGesture = UITapGestureRecognizer(target: self, action:  #selector(toCurrencyOnTap))
		fromCurrencyCell.addGestureRecognizer(fromCurrencyGesture)
		toCurrencyCell.addGestureRecognizer(toCurrencyGesture)
		
		stackToButtons.alignment = .center
		stackToButtons.axis = .vertical
		stackToButtons.distribution = .fillEqually
		stackToButtons.spacing = 30
		
		stackToButtons.anchor(
			right: (rightAnchor, 0),
			left: (leftAnchor, 0),
			centerY: (centerYAnchor, -40)
		)
		
		fromCurrencyCell.anchor(
			right: (stackToButtons.rightAnchor, 0),
			left: (stackToButtons.leftAnchor, 0)
		)
		
		toCurrencyCell.anchor(
			right: (stackToButtons.rightAnchor, 0),
			left: (stackToButtons.leftAnchor, 0)
		)
		
		slider.anchor(
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (bottomAnchor, 30)
		)
	}
	
	@objc private func fromCurrencyOnTap() {
		fromOnClick?()
	}
	
	@objc private func toCurrencyOnTap() {
		toOnClick?()
	}
	
	@objc private func sliderValueDidChange(_ sender: UISlider) {
		slidePosition = sender.value
		wasSlided?()
	}
	
	public func showFromCurrencyView(code: String, value: Float) {
		self.fromCurrencyCell.showCurrency(code: code, value: value)
	}
	
	public func showToCurrencyView(code: String, value: Float) {
		self.toCurrencyCell.showCurrency(code: code, value: value)
	}
	
	
	public func setMaxMinSlider(_ min: Float, _ max: Float) {
		slider.minimumValue = min
		slider.maximumValue = max
		slider.isContinuous = true
	}
}
