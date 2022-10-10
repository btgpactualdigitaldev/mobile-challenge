//
//  CurrencyViewController.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var labelMoedaOrigem: UILabel!
    @IBOutlet weak var labelMoedaDestino: UILabel!
    @IBOutlet weak var moedaConvertida: UILabel!
    @IBOutlet weak var textFieldValor: UITextField!
    
    private var viewModel: CurrencyConverterViewModel!
    private var currencyFrom: String = ""
    private var currencyTo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Conversor"
        
    }
    
    @IBAction func didTapMoedaOrigem(_ sender: Any) {
        let vc = SearchViewController(delegate: self, isSource: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapMoedaDestino(_ sender: Any) {
        let vc = SearchViewController(delegate: self, isSource: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapConverter(_ sender: Any) {
        if currencyFrom.isEmpty || currencyTo.isEmpty || textFieldValor.text?.isEmpty ?? true {
            return
        }
        
        fetchCurrencyToUpdateView()
    }
    
    private func fetchCurrencyToUpdateView() {
        self.viewModel = CurrencyConverterViewModel()
        self.viewModel.bindViewModelToController = { [weak self] in
            guard let self = self else { return }
            
            self.updateUI()
        }
    }
    
    private func updateUI() {
        let doubleValue = Double(textFieldValor.text ?? "0") ?? 0
        let converted = viewModel.convert(from: labelMoedaOrigem.text!, to: labelMoedaDestino.text!, value: doubleValue)
        self.moedaConvertida.text = String(format: "%.2f", converted)
    }
}

extension CurrencyViewController: SearchViewDelegate {
    func didSelectFrom(selected: String) {
        self.currencyFrom = selected
        self.labelMoedaOrigem.text = selected
    }
    
    func didSelectTo(selected: String) {
        self.currencyTo = selected
        self.labelMoedaDestino.text = selected
    }
}
