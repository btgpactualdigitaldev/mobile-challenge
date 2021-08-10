//
//  ConversionViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class ConversionViewController: BTGViewController {
	
	private let viewModel = ConversionViewModel()
	private var conversionView: ConversionView { return self.view as! ConversionView }
	private var fromCurrencyCode = "USD"
	private var toCurrencyCode: String?
	private var quantity: Float = 1
	private var slider = UISlider()
	private var quotation: Float = 0.0
	
	var delegate: ConversionDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		conversionView.setMaxMinSlider(quantity, 100)
		conversionView.showFromCurrencyView(code: fromCurrencyCode, value: self.quantity)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
		bindUI()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func loadView() {
		self.view = ConversionView(frame: UIScreen.main.bounds)
	}
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
	private func bindUI() {
		conversionView.fromOnClick = { [weak self] in
			guard let self = self else { return }
			let viewController = AvaliableCurrenciesViewController(filling: .fromCurrency)
			viewController.delegate = self
			self.navigationController?.pushViewController(viewController, animated: true)
		}
		
		conversionView.toOnClick = { [weak self] in
			guard let self = self else { return }
			let viewController = AvaliableCurrenciesViewController(filling: .toCurrency)
			viewController.delegate = self
			self.navigationController?.pushViewController(viewController, animated: true)
		}
		
		conversionView.wasSlided = { [weak self] in
			guard let self = self else { return }
			self.quantity = self.conversionView.slidePosition
			self.conversionView.showFromCurrencyView(code: self.fromCurrencyCode, value: self.quantity)
			if let toCurrencyCode = self.toCurrencyCode {
				self.conversionView.showToCurrencyView(code: toCurrencyCode, value: self.quotation * self.quantity)
			}
		}
	}
}

// MARK: Conversion Delegate
extension ConversionViewController: ConversionDelegate {
	func getFromCurrency(selectedCurrencyCode: String) {
		self.fromCurrencyCode = selectedCurrencyCode
		conversionView.showFromCurrencyView(code: fromCurrencyCode, value: self.quantity)
		self.getQuote()
	}
	
	func getToCurrency(selectedCurrencyCode: String) {
		self.toCurrencyCode = selectedCurrencyCode
		self.getQuote()
	}
}

// MARK: Convertion API Call
extension ConversionViewController {
	func getQuote() {
		if let toCurrencyCode = toCurrencyCode {
			self.showLoading()
			viewModel.getQuotationValue(from: fromCurrencyCode, to: toCurrencyCode, quantity: quantity) { [weak self] result in
				guard let self = self else { return }
				self.hideLoading()
				switch result {
				case .success(let value):
					self.conversionView.showToCurrencyView(code: toCurrencyCode, value: value)
					self.quotation = value / self.quantity
				case .failure(let error):
					self.handlerError(error)
				}
			}
		}
	}
}
