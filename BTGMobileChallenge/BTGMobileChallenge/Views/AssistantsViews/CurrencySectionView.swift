//
//  CurrencySectionView.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class CurrencySectionView: UIView {
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 25)
		label.textColor = .white
		return label
	}()
	private let tipLabel: UILabel = {
		let label = UILabel()
		label.text = AppStrings.shared.clickToChoiceTip
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = .white
		return label
	}()
	private let currencyView: UIView = {
		let view = UIView()
		return view
	}()
	private let codeLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 30)
		label.text = "-"
		label.textColor = .white
		return label
	}()
	private let valueLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 30)
		label.text = "-"
		label.textColor = .white
		return label
	}()
	private let separatorTopView: UIView = {
		let view = UIView()
		return view
	}()
	private let separatorBottomView: UIView = {
		let view = UIView()
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	convenience init(title: String) {
		self.init(frame: .zero)
		titleLabel.text = title
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(titleLabel)
		addSubview(tipLabel)
		addSubview(currencyView)
		addSubview(separatorTopView)
		addSubview(separatorBottomView)
		currencyView.addSubview(codeLabel)
		currencyView.addSubview(valueLabel)
		
		separatorTopView.backgroundColor = .gray
		separatorBottomView.backgroundColor = .gray
		setupConstraints()
	}
	
	private func setupConstraints() {
		titleLabel.anchor(
			top: (topAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20)
		)
		
		tipLabel.anchor(
			top: (titleLabel.bottomAnchor, 1),
			centerX: (centerXAnchor, 0)
		)
		
		currencyView.anchor(
			top: (tipLabel.bottomAnchor, 20),
			bottom: (bottomAnchor, 20),
			centerX: (centerXAnchor, 0),
			height: 44
		)
		
		codeLabel.anchor(
			left: (currencyView.leftAnchor, 0),
			centerY: (currencyView.centerYAnchor, 0)
		)
		
		valueLabel.anchor(
			right: (currencyView.rightAnchor, 0),
			left: (codeLabel.rightAnchor, 20),
			centerY: (currencyView.centerYAnchor, 0)
		)
		
		separatorTopView.anchor(
			top: (topAnchor, 0),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			height: 1
		)
		
		separatorBottomView.anchor(
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (bottomAnchor, 0),
			height: 1
		)
	}
	
	func showCurrency(code: String, value: Float) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.codeLabel.text = code
			self.valueLabel.text = "\(Float(round(1000*value)/1000))"
		}
	}
}
