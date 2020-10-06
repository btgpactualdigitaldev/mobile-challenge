//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 03/10/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var destinyButton: UIButton!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var converterButton: UIButton!
    @IBOutlet weak var convertedLabel: UILabel!
    
    var viewModel = CurrencyConverterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        self.configureView()
        self.fetchQuotes()
    }
    
    @IBAction func converterAction(_ sender: UIButton) {
        
        guard let _ = viewModel.selectedOrigin else {
            showAlert(title: "Atenção", message: ErrorHandler.emptyOriginSelected.rawValue)
            return
        }
        
        guard let _ = viewModel.selectedDestiny,
           let _ = viewModel.selectedDestiny else {
            showAlert(title: "Atenção", message: ErrorHandler.emptyDestinySelected.rawValue)
            return
        }
        
        if let value = currencyTextField.text {
            
            guard let valueFloat = Float(value) else {
                showAlert(title: "Atenção", message: ErrorHandler.invalidValue.rawValue)
                return }
            
            if valueFloat <= 0 {
                showAlert(title: "Atenção", message: ErrorHandler.zeroValueError.rawValue)
                return
            } else {
                self.convertedLabel.text = viewModel.converterCurrency(valueFloat)
            }
        } else {
            showAlert(title: "Atenção", message: ErrorHandler.invalidValue.rawValue)
            return
        }
    }
    
    @IBAction func originAction(_ sender: UIButton) {
        let vc = CurrencyListViewController(type: .origin)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func destinyAction(_ sender: UIButton) {
        let vc = CurrencyListViewController(type: .destiny)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchQuotes() {
        
        CurrencyAPI.shared.fetchQuotes { (result) in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.viewModel.setQuotesArray(quoteList: list)
                }
            case .error(let error):
                self.showAlert(message: error.rawValue)
            }
        }
    }
    
    func configureView() {
        self.originButton.layer.cornerRadius = 4
        self.destinyButton.layer.cornerRadius = 4
        self.currencyTextField.layer.cornerRadius = 4
        self.converterButton.layer.cornerRadius = 4
    }
}

extension CurrencyConverterViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CurrencyConverterViewController: SelectCurrencyDelegate {
    func getSelectCurrency(type: TypeConverter, currency: Currency) {
        
        self.viewModel.quoteSelect(type: type, code: currency.code)
        
        switch type {
        case .origin:
            self.originButton.setTitle(currency.code, for: .normal)
        case .destiny:
            self.destinyButton.setTitle(currency.code, for: .normal)
        }
    }
    
}
