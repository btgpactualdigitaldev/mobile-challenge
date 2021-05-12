//
//  CurrencyConversionViewController.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    @IBOutlet weak var firstCurrencyButton: UIButton!
    @IBOutlet weak var secondCurrencyButton: UIButton!
    @IBOutlet weak var firstCurrencyTextField: UITextField!
    @IBOutlet weak var secondCurrencyTextField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private let viewModel = CurrencyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getCurrencies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let destination = segue.destination as? CurrencySelectionViewController else { return }
        destination.viewModel = self.viewModel
        destination.currencyType = segue.identifier == "firstCurrencySegue" ? .first : .second
    }
    
    func setup() {
        self.updateViewState(success: false)
        self.viewModel.delegate = self
        self.firstCurrencyTextField.addTarget(self, action: #selector(CurrencyConversionViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.viewModel.convertValueFrom(text: textField.text)
    }
}

extension CurrencyConversionViewController: CurrencyViewModelDelegate {
    func showLoading() {
        self.activity.startAnimating()
    }
    
    func hideLoading() {
        self.activity.stopAnimating()
    }
    
    func genericError() {
        let alert = UIAlertController(title: "Atenção", message: "Erro obtendo cotações de moedas. Verifique sua conexão de internet e tente novamente", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Tentar Novamente", style: .default, handler: { (action) in
            self.viewModel.getCurrencies()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func equalCurrenciesError() {
        let alert = UIAlertController(title: "Atenção", message: "Por favor, selecione moedas diferentes para efetuar a conversão.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func updateViewState(success: Bool) {
        self.firstCurrencyButton.isEnabled = success
        self.secondCurrencyButton.isEnabled = success
        self.firstCurrencyButton.setTitle(self.viewModel.firstCurrency?.symbol ?? "Moeda", for: .normal)
        self.secondCurrencyButton.setTitle(self.viewModel.secondCurrency?.symbol ?? "Moeda", for: .normal)
        self.firstCurrencyTextField.isEnabled = self.viewModel.firstCurrency != nil
        if self.viewModel.firstCurrency == nil || self.viewModel.secondCurrency == nil {
            self.secondCurrencyTextField.text = nil
        }
    }
    
    func showConverted(value: String) {
        self.secondCurrencyTextField.text = value
    }
}

