//
//  ExchangeViewModel.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit

class ExchangeViewModel {
    fileprivate let localCurrency: Currency
    fileprivate let foreignCurrency: Currency
    let labelText = "Ultima atualização em:"
    
    init(localCurrency: Currency, foreignCurrency: Currency) {
        self.localCurrency = localCurrency
        self.foreignCurrency = foreignCurrency
    }
    
    func goToList() {
        Router.shared.setViewController(viewController: CurrenciesListViewController())
    }
    
    func setLabels(localLabel: UILabel, foreignLabel: UILabel) {
        localLabel.text = localCurrency.abbreviation
        foreignLabel.text = foreignCurrency.abbreviation
    }
    
    func convertLocalToForeign(value: Double) -> Double {
        let localInUsd = value / localCurrency.usdQuote
        return localInUsd * foreignCurrency.usdQuote
    }
    
    func isValueDecimal(textField: UITextField, typedValue: String) -> Bool {
        let currentValue = textField.text ?? ""
        let changedValue = (currentValue + typedValue).replacingOccurrences(of: ",", with: ".")
        return changedValue == "" || (Double(changedValue) != nil)
    }
    
    func checkConnection(container: UIView, label: UILabel) {
        if !NetworkHelper().isConnected() {
            let lastUpdate = AppUserDefaults().getDate(key: .LastUpdate)!
            container.isHidden = false
            label.text = "\(labelText) \(lastUpdate)"
        }
    }
}
