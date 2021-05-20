//
//  CurrencyConverterViewController.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Combine
import UIKit

class CurrencyConverterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var valueInputTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var originCurrencyPickerView: UIPickerView!
    @IBOutlet private weak var destinyCurrencyPickerView: UIPickerView!

    // MARK: - Constants

    private let numberOfDigits: Double = 3

    // MARK: - Variables

    private var currencyConversionViewModel = CurrencyConverterViewModel(servicesProvider: CurrencyConverterServiceProvider())
    private var currencyListviewModel = CurrencyListViewModel(servicesProvider: CurrencyListServiceProvider())
    private var convertedCurrencySubscriber: AnyCancellable?
    private var convertedListSubscriber: AnyCancellable?
    private var currencyList: [String]? {
        didSet {
            if oldValue == nil {
                resultLabel.text = "---"
            }
            originCurrencyPickerView.reloadComponent(0)
            destinyCurrencyPickerView.reloadComponent(0)
        }
    }
    private var roundMultiplier: Double {
         return pow(10, numberOfDigits)
    }

    // MARK: - Lyfecycle and constructors

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupBindings()
        setupToHideKeyboardOnTapOnView()
    }

    // MARK: - Private functions

    private func setupDelegate() {
        valueInputTextField.delegate = self
        valueInputTextField.keyboardType = .decimalPad
        originCurrencyPickerView.delegate = self
        originCurrencyPickerView.dataSource = self
        destinyCurrencyPickerView.delegate = self
        destinyCurrencyPickerView.dataSource = self
    }

    private func setupBindings() {
        convertedCurrencySubscriber = currencyConversionViewModel.$convertedValue.receive(on: DispatchQueue.main).map{ "\(Double(round(self.roundMultiplier * ($0 ?? 0))/self.roundMultiplier))" }.assign(to: \.resultLabel.text, on: self)
        convertedListSubscriber = currencyListviewModel.$currencyList.receive(on: DispatchQueue.main).map { $0.map{ $0.map{ $0.key } } }.assign(to: \.currencyList, on: self)
    }

    private func convertValue() {
        let originRow = originCurrencyPickerView.selectedRow(inComponent: 0)
        let destinyRow = destinyCurrencyPickerView.selectedRow(inComponent: 0)

        guard let text = valueInputTextField.text,
            let value = Double(text),
            let originCurrency = currencyList?[originRow],
            let destinyCurrency = currencyList?[destinyRow] else { return }

        currencyConversionViewModel.convert(from: originCurrency, to: destinyCurrency, value: value)
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        convertValue()
    }
}

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList?.count ?? 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList?[row] ?? "Unable to load data"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        convertValue()
    }
}
