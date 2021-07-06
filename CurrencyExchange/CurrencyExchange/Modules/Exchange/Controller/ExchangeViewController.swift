//
//  ExchangeViewController.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

protocol ExchangeViewControllerDelegate: class {
    func presentCurrencyListWithButtonType(_ type: CurrencyButtonType)
}

enum CurrencyButtonType {
    case origin, destination
}

class ExchangeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: ExchangeViewControllerDelegate?
    
    var viewModel: ExchangeViewModel
    
    private var exchangeView: ExchangeView = {
        let view = ExchangeView(frame: .zero)
        return view
    }()
    
    init(viewModel: ExchangeViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        
        self.exchangeView.originCurrencyButton.addTarget(self, action: #selector(tappedOnOriginButton), for: .touchUpInside)
        
        self.exchangeView.destinationCurrencyButton.addTarget(self, action: #selector(tappedOnDestinationButton), for: .touchUpInside)
        
        self.exchangeView.convertButton.addTarget(self, action: #selector(tappedOnConverterButton), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
        
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = exchangeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    // MARK: - Selectors
    
    @objc private func tappedOnOriginButton(){
        self.coordinator?.presentCurrencyListWithButtonType(.origin)
    }
    
    @objc private func tappedOnDestinationButton(){
        self.coordinator?.presentCurrencyListWithButtonType(.destination)
    }
    
    @objc private func tappedOnConverterButton(){
        self.viewModel.executeConverterWithExchangeValue(exchangeView.exchangeTextField.text)
    }
    
    // MARK: - Methods
    
    func setupOriginButton(){
        self.exchangeView.originCurrencyButton.setTitle(viewModel.originCurrency?.code, for: .normal)
    }
    
    func setupDestinationButton(){
        self.exchangeView.destinationCurrencyButton.setTitle(viewModel.destinationCurrency?.code, for: .normal)
    }

    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExchangeViewController: ExchangeViewModelDelegate {
    
    func willBeginCurrencyExchange() {
        self.exchangeView.showLoadingIndicator(view: exchangeView)
    }
    
    func didFinishCurrencyExchange(message: String?, convertedValue: Double?) {
        if let message = message {
            showErrorWithTitle("Erro", withMessage: message)
        }else if let convertedValue = convertedValue {
            DispatchQueue.main.async {
                guard let originCurrency = self.viewModel.destinationCurrency else {
                    return
                }
                let convertedValueString = "\(originCurrency.code): \(String(format: "%.2f", convertedValue))"
                self.exchangeView.resultValueOfExchangeLabel.text = convertedValueString
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.exchangeView.dismissLoadingIndicator()
        }
    }
    
    func handleConverterError(message: String) {
        showErrorWithTitle("Erro", withMessage: message)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.exchangeView.dismissLoadingIndicator()
        }
    }
}
