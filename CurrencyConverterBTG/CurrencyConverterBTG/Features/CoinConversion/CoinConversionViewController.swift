//
//  CoinConversionViewController.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import UIKit

enum ViewState {
    case loading
    case show
    case error
}

enum CurrencyType {
    case origin
    case destiny
}

enum LockState {
    case lock
    case unlock
}

protocol CoinConversionViewControllerDelegate: AnyObject {
    func updateSelectedCurrency(currencyModel: CurrencyModel)
}

class CoinConversionViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var valueTextField: CustomTextField!
    @IBOutlet private weak var originButton: CustomButton!
    @IBOutlet private weak var destinyButton: CustomButton!
    @IBOutlet private weak var convertButton: CustomButton!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: CustomButton!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: - Private properties
    
    
    private let titleNavigationBar: String = "Currency Converter"
    private var openCurrencyType: CurrencyType = .origin
    private var ignoreAlert: Bool = false
    
    private var viewState: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                switch self.viewState {
                case .loading:
                    self.viewInteraction(.lock)
                    self.errorView.isHidden = true
                case .show:
                    self.viewInteraction(.unlock)
                    self.errorView.isHidden = true
                case .error:
                     self.viewInteraction(.unlock)
                    self.errorView.isHidden = false
                }
            }
        }
    }
    
    
    // MARK: - Public properties
    
    
    var viewModel: CoinConversionViewModel?

    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        requestData()
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func didTouchConverterButton(_ sender: Any) {
        view.endEditing(true)
        
        if let errorMessage: String = viewModel?.validate(text: valueTextField.text) {
            if !ignoreAlert {
                showAlert(error: nil, message: errorMessage)
            }
            self.resultLabel.text = nil
            ignoreAlert = false
        } else {
            guard let valueString: String = valueTextField.text else { return }
            viewInteraction(.lock)
            viewModel?.convertCurrency(value: valueString, completion: { [weak self] (valueConverted, error) in
                guard error == nil,
                    let originSymbol: String = self?.viewModel?.selectedOriginCurrency?.symbol,
                    let destinySymbol: String = self?.viewModel?.selectedDestinyCurrency?.symbol,
                    let value: Double = valueConverted else {
                        DispatchQueue.main.async {
                            self?.resultLabel.text = nil
                        }
                        self?.showAlert(error: error)
                        self?.viewInteraction(.unlock)
                        return
                }
                
                let valueConvertedString: String = String(format: "%.2f", value).toCurrency()
                
                DispatchQueue.main.async {
                    self?.resultLabel.text = "\(valueString) \(originSymbol) / \(valueConvertedString) \(destinySymbol)"
                    
                    if let onePrice: Double = self?.viewModel?.onePrice,
                        onePrice > 0 {
                        self?.valueLabel.text = "1 \(originSymbol) = \(String(format: "%.6f", onePrice)) \(destinySymbol)"
                    } else {
                        self?.valueLabel.text = ""
                    }
                    
                    if let priceDate: String = self?.viewModel?.priceDate {
                        self?.dateLabel.text = "Date Price: \(priceDate)"
                    } else {
                        self?.dateLabel.text = ""
                    }
                    self?.viewInteraction(.unlock)
                }
            })
        }
    }
    
    @IBAction func didTouchOriginButton(_ sender: Any) {
        openCurrencyList(currencyType: .origin)
    }
    
    @IBAction func didTouchDestinyButton(_ sender: Any) {
        openCurrencyList(currencyType: .destiny)
    }
    
    @IBAction func didTouchTryAgain(_ sender: Any) {
        viewState = .loading
        requestData()
    }
}


// MARK: - Private Methods


extension CoinConversionViewController {
    
    private func setupLayout() {
        title = titleNavigationBar
        
        valueTextField.configureCustomButton(image: UIImage(systemName: "arrow.2.squarepath")!, imageSize: 44.0)
        
        valueTextField.onCustomButtonTouch = { [weak self] in
            self?.viewModel?.invertCurrency()
            self?.updateButtonTitle()
            self?.ignoreAlert = true
            self?.didTouchConverterButton(self?.convertButton as Any)
        }
        
        originButton.configure(style: .line)
        destinyButton.configure(style: .line)
        convertButton.configure(style: .normal)
        tryAgainButton.configure(style: .line)
        
        loadingView.alpha = 0.3
        
        cardView.cornerRadius = 4.0
        cardView.dropShadow()
    }
    
    private func showAlert(error: Error?, message: String? = nil) {
        var errorMessage: String = ""
        if let error: Error = error {
            errorMessage = error.localizedDescription
        } else if let message: String = message{
            errorMessage = message
        }
            
        UIAlertController.showOkAlert(withTitle: titleNavigationBar, message: errorMessage, forViewController: self)
    }
    
    private func updateButtonTitle() {
        DispatchQueue.main.async {
            self.originButton.setTitle(self.viewModel?.selectedOriginCurrency?.description, for: .normal)
            self.destinyButton.setTitle(self.viewModel?.selectedDestinyCurrency?.description, for: .normal)
        }
    }
    
    private func openCurrencyList(currencyType: CurrencyType) {
        guard let currencyListViewModel: CurrencyListViewModel = viewModel?.currencyListViewModel(currencyType: currencyType) else { return }
        openCurrencyType = currencyType
        let currencyListViewController: CurrencyListViewController = CurrencyListViewController(viewModel: currencyListViewModel)
        currencyListViewController.delegate = self
        navigationController?.pushViewController(currencyListViewController, animated: true)
    }
    
    private func requestData() {
        viewModel?.requestCurrencies(completion: { [weak self] (error) in
            guard error == nil else {
                self?.viewState = .error
                DispatchQueue.main.async {
                    self?.setupErrorView(error)
                }
                return
            }
            self?.viewState = .show
            self?.updateButtonTitle()
        })
    }
    
    private func setupErrorView(_ error: Error?) {
        if let error: Error = error {
            errorLabel.text = error.localizedDescription
        } else {
            errorLabel.text = "An unexpected error has occurred"
        }
    }
    
    private func viewInteraction(_ lockState: LockState) {
        DispatchQueue.main.async {
            switch lockState {
            case .lock:
                self.loadingView.isHidden = false
                self.loadingIndicatorView.startAnimating()
            case .unlock:
                self.loadingView.isHidden = true
                self.loadingIndicatorView.stopAnimating()
            }
        }
    }
}


// MARK: - UITextFieldDelegate


extension CoinConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString: String = string.digits
        
        if !newString.isEmpty,
            let text: String = textField.text {
            let nsText: NSString = NSString(string: text)
            let newText: String = nsText.replacingCharacters(in: range, with: newString)
            
            textField.text = newText.toCurrency()
        }
        return false
    }
}


// MARK: - CoinConversionViewControllerDelegate


extension CoinConversionViewController: CoinConversionViewControllerDelegate {
    func updateSelectedCurrency(currencyModel: CurrencyModel) {
        viewModel?.updateCurrency(currencyType: openCurrencyType, currencyModel: currencyModel) { [weak self] in
            self?.updateButtonTitle()
            ignoreAlert = true
            self?.didTouchConverterButton(self?.convertButton as Any)
        }
    }
}
