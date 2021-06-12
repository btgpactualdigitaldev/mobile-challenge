//
//  MainViewController.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 08/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class CurrencyLiveViewController: UIViewController {
    
    @IBOutlet weak var buttonFromCurrency: UIButton!
    @IBOutlet weak var buttonToCurrency: UIButton!
    @IBOutlet weak var buttonConvert: UIButton!
    @IBOutlet weak var toCurrencyLbl: UILabel!
    @IBOutlet weak var currencyTextField: UITextField!
    
    var viewModel: CurrencyLiveViewModelContract
    var viewData: [CurrencyLiveViewData] = []
    
    var fromCurrency: String = "BRL"
    var tocurrency: String = "USD"
    var amount: String = "1.00"
    
    required init(with viewModel: CurrencyLiveViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: "CurrencyLiveViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonFromCurrency.setTitle(fromCurrency, for: .normal)
        self.buttonToCurrency.setTitle(tocurrency, for: .normal)
        self.currencyTextField.text = "1.00"
        self.fetch()
    }
    
    func fetch() {
        self.viewModel.fetch { result in
            switch result {
            case .success(let viewData):
                self.convertAmount(data: viewData)
            case .failure(let error):
                self.showAlert(title: "Atenção", message: error.localizedDescription)
            }
        }
    }
    
    func convertAmount(data: [CurrencyLiveViewData]) {
        let finalValue = Utils.shared.convertFinalValue(quotes: data,
                                       fromCurrency: self.fromCurrency,
                                       toCurrency: self.tocurrency,
                                       amount: self.amount)
        self.toCurrencyLbl.text = finalValue

    }
    @IBAction func currencyText(_ sender: Any) {
       
        if let amount = self.currencyTextField.text?.currencyInputFormatting() {
            self.amount = amount
            self.currencyTextField.text = amount
        } else {
            self.buttonConvert.isEnabled = false
        }
    }
    
    @IBAction func openCurrencyListToBeConverted(_ sender: Any) {
        guard let navigation = self.navigationController else { return }
        let coordinator = CurrencyListCoordinator(navigation: navigation, targertViewController: self) { currency in
            self.buttonFromCurrency.setTitle(currency.currencyCode, for: .normal)
            self.fromCurrency = currency.currencyCode
        }
        let _ = coordinator.start(with: .sheetView(animated: false))
    }
    
    
    @IBAction func openCurrencyListToConvert(_ sender: Any) {
        guard let navigation = self.navigationController else { return }
        let coordinator = CurrencyListCoordinator(navigation: navigation, targertViewController: self) { currency in
            self.buttonToCurrency.setTitle(currency.currencyCode, for: .normal)
            self.tocurrency = currency.currencyCode
        }
        let _ = coordinator.start(with: .sheetView(animated: false))
    }
    
    @IBAction func convertAction(_ sender: Any) {
        self.fetch()
    }
    
}
