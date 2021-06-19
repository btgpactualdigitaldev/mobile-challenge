//
//  CurrencyConverterViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

// Class

final class CurrencyConverterViewController: ViewController<CurrencyConverterView> {
    
    // Properties

    private var viewModel: CurrencyConverterViewModel
    private var firstMoment: Bool = true

    // Lifecycle

    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init()
        self.contentView.setup(delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCurrencyView()
    }
}

// Setup Views

fileprivate extension CurrencyConverterViewController {
    func setupActions() {
        setUpButton()
        setUpFromCurrentyButton()
        setUpToCurrentyButton()
        setUpToCalculationButton()
    }

    func setUpButton() {
        contentView.currencyButton.addTarget(self, action: #selector(openList),
                                 for: .touchUpInside)
    }

    func setUpFromCurrentyButton() {
        contentView.fromCurrencyButton.addTarget(self,
                                     action: #selector(fromPickList),
                                     for: .touchUpInside)
    }

    func setUpToCurrentyButton() {
        contentView.toCurrencyButton.addTarget(self,
                                   action: #selector(toPickList),
                                   for: .touchUpInside)
    }

    func setUpToCalculationButton() {
        contentView.calculationButton.addTarget(self,
                                    action: #selector(calculate),
                                    for: .touchUpInside)
    }

    func updateCurrencyView() {
        calculate()
        updateButtonView()
    }

    func updateButtonView() {
        contentView.fromCurrencyButton.setTitle(viewModel.fromCurrency, for: .normal)
        contentView.toCurrencyButton.setTitle(viewModel.toCurrency, for: .normal)
    }
}

// Actions

extension CurrencyConverterViewController {
    @objc private func openList() {
        viewModel.openSupporteds()
    }

    @objc private func fromPickList() {
        viewModel.pickSupporteds(type: .from)
    }

    @objc private func toPickList() {
        viewModel.pickSupporteds(type: .to)
    }

    @objc private func calculate() {
        guard let values = viewModel.calculateConvertion().0 else {
            guard !firstMoment else {
                firstMoment.toggle()
                return
            }
            if let error = viewModel.calculateConvertion().1 {
                self.showAlert("Ops...", error)
                return
            }
            self.showAlert("Algo inesperado aconteceu na conversão")
            return
        }
        viewModel.currencyValue = values.valueFrom
        contentView.fromCurrencyLabel.text = values.valueFrom.isEmpty ? "1,00" : values.valueFrom
        contentView.toCurrencyLabel.text =  values.valueFrom.isEmpty ? "1,00" : values.valueTo
    }
}

// CurrencyConverterViewDelegate

extension CurrencyConverterViewController: CurrencyConverterViewDelegate {
    var currencyValueIsEmpty: Bool { viewModel.currencyValueIsEmpty }

    func updateValue(_ value: String) {
        viewModel.currencyValue = value
    }
}
