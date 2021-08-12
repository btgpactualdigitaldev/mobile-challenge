//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    private lazy var contentView = CurrencyConverterView()
        .set(\.fromCurrencySelectButton.tapAction, to: didTapFromCurrency)
        .set(\.toCurrencySelectButton.tapAction, to: didTapToCurrency)
        .run {
            $0.swapButton.addTarget(self, action: #selector(didTapSwapButton), for: .touchUpInside)
            $0.fromValueTextField.addTarget(self, action: #selector(didEndEditingTextField), for: .editingChanged)
        }
    
    // MARK: - Properties
    
    private var viewModel: CurrencyConverterViewModeling
    
    // MARK: - Initializers
    
    init(viewModel: CurrencyConverterViewModeling = CurrencyConverterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CurrencyConverterViewModel()
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        view = contentView
        viewModel.delegate = self
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadCurrencyLiveQuote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentView.fromValueTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    func didTapFromCurrency() {
        let currencyListModal = viewModel.getSelectFromCurrencyScene()
        present(currencyListModal, animated: true, completion: nil)
    }
    
    func didTapToCurrency() {
        let currencyListModal = viewModel.getSelectToCurrencyScene()
        present(currencyListModal, animated: true, completion: nil)
    }
    
    @objc func didTapSwapButton() {
        viewModel.swapCurrencies()
    }
    
    @objc func didEndEditingTextField() {
        viewModel.fromCurrencyValue = contentView.fromValueTextField.text
    }
    
}

// MARK: - CurrencyConverterViewModelDelegate

extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    
    func updateUI() {
        contentView.fromCurrencySelectButton.primaryLabel.text = viewModel.fromCurrencyName
        contentView.fromCurrencySelectButton.secondaryLabel.text = viewModel.fromCurrencyCode
        
        contentView.toCurrencySelectButton.primaryLabel.text = viewModel.toCurrencyName
        contentView.toCurrencySelectButton.secondaryLabel.text = viewModel.toCurrencyCode
        
        contentView.resultValueLabel.text = viewModel.toCurrencyValue
    }
    
    func presentError(with message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func shouldShowLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.contentView.isLoading = isLoading
        }
    }
    
}
