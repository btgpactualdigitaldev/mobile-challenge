//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import Foundation
import UIKit

protocol OriginSelected {
    func onOriginSelected(origin: Origin, title: String, currencyCode: String)
}

protocol HomeControllerDelegate {
    func originUpdated(origin: Origin, title: String, currencyCode: String)
}

enum Origin {
    case currency
    case newCurrency
}

final class HomeViewModel {
    var coordinator: MainCoordinator?
    var controllerDelegate: HomeControllerDelegate?
    var quotations: Quotation?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        fetchQuotationsList()
    }
    
    @objc func didTapCurrency(_ sender: UIButton!) {
        coordinator?.openList(origin: .currency)
    }
    
    @objc func didTapNewCurrency(_ sender: UIButton) {
        coordinator?.openList(origin: .newCurrency)
    }
    
    private func fetchQuotationsList(){
        APICaller.shared.getQuotations{ [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let model):
                    self?.quotations = model
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func convert(receivedValue: Double, from: String, to: String) -> Double {
        let valueFrom = findQuotation(currency: from)
        let valueTo = findQuotation(currency: to)
        let valueUSD = receivedValue / valueFrom
        return valueUSD * valueTo * 100
    }
    
    func findQuotation(currency: String) -> Double {
        guard let checkedQuotation = self.quotations else { return 0 }
        let result = checkedQuotation.quotes.first(where: {$0.key.elementsEqual("USD\(currency)")})
        return result?.value ?? 0
    }
    
    func formatTextField(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
}

extension HomeViewModel: OriginSelected {
    func onOriginSelected(origin: Origin, title: String, currencyCode: String) {
        controllerDelegate?.originUpdated(origin: origin, title: title, currencyCode: currencyCode)
    }
    
}
