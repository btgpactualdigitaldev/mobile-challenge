//
//  SelectedCurrencyProtocol.swift
//  currency-converter
//
//  Created by Admin Colaborador on 09/10/20.
//

import Foundation

protocol SelectedCurrencyDelegate: class {
    
    func setSelectedCurrency(_ currency: CurrencyInfo)
    
}
