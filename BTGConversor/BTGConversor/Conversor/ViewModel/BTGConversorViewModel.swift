//
//  BTGConversorViewModel.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

protocol BTGConversorViewDelegate: AnyObject {
    func updateCurrencyFrom(_ viewModel: BTGConversorViewModel, title: String)
    func updateCurrencyTo(_ viewModel: BTGConversorViewModel, title: String)
    func clearTextField(_ viewModel: BTGConversorViewModel)
    func updateConversion(_ viewModel: BTGConversorViewModel, value: String?)
    func updateConversionResult(_ viewModel: BTGConversorViewModel, value: String?)
    func enableTextField(_ viewModel: BTGConversorViewModel)
    
}

final class BTGConversorViewModel: BTGViewModelProtocol {
    
    let service: ConversorService
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    weak var viewDelegate: BTGConversorViewDelegate?
    var quotaData: CurrencyLiveQuotas? {
        didSet {
            quotaData?.quotes.forEach({ (currency) in
                quotas.append(Quota(code: currency.key, value: currency.value))
            })
        }
    }
    var quotas: [Quota] = []
    var currencyFrom: String = "Moeda origem"
    var currencyTo: String = "Moeda Destino"
    let defaultCurrency: String = "USD"
    var amount: Int = 0
    
    lazy var title: String = {
        return "Conversor de Moedas"
    }()
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    init(_ service: ConversorService) {
        self.service = service
    }
    
    func fetchQuota() {
        service.fetchQuota { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let quota):
                self.quotaData = quota
                self.viewDelegate?.enableTextField(self)
            case .failure(let error):
                self.coordinatorDelegate?.showAlert(self, message: error.localizedDescription)
            }
        }
    }
    
    private func getCurrencyAmount() -> Double {
        return Double(amount/100) + Double(amount%100)/100
    }
    
    func getAmountString(_ string: String) {
        if let digit = Int(string) {
            amount = amount * 10 + digit
            let result = getCurrencyAmount()
            viewDelegate?.updateConversion(self, value: formatter.string(from: NSNumber(value: result)))
            convert(result)
        }
        
        if string == "" {
            amount = amount / 10
            let result = getCurrencyAmount()
            viewDelegate?.updateConversion(self, value: formatter.string(from: NSNumber(value: result)))
            convert(result)
        }
    }
    
    private func convert(_ amount: Double){
        guard let quotaFrom =  getQuota("USD\(currencyFrom)"), let quotaTo = getQuota("USD\(currencyTo)") else {
            coordinatorDelegate?.showAlert(self, message: "Desculpa! Não podemos efetuar essa conversão")
            viewDelegate?.clearTextField(self)
            return
        }
        
        var convertedToUSD = 0.0
        if quotaFrom.value != 0 {
            convertedToUSD = amount / quotaFrom.value
        }
        
        let convertedToCurrency = convertedToUSD * quotaTo.value
        viewDelegate?.updateConversionResult(self, value: formatter.string(from: NSNumber(value: convertedToCurrency)))
    }
    
    private func getQuota(_ conversor: String) -> Quota? {
        return  quotas.filter({ $0.code == conversor }).first
    }
    
    func didTapCurrencyFrom() {
        coordinatorDelegate?.openLists(self, currencyClicked: { (currency) in
            self.currencyFrom = currency.0
            self.amount = 0
            self.viewDelegate?.clearTextField(self)
            self.viewDelegate?.updateCurrencyFrom(self, title: currency.0)
        })
    }
    
    func didTapCurrencyTo() {
        coordinatorDelegate?.openLists(self, currencyClicked: { (currency) in
            self.currencyTo = currency.0
            self.amount = 0
            self.viewDelegate?.clearTextField(self)
            self.viewDelegate?.updateCurrencyTo(self, title: currency.0)
        })
    }
    
}
