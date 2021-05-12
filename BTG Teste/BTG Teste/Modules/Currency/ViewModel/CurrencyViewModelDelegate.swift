//
//  CurrencyViewModelDelegate.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

protocol CurrencyViewModelDelegate {
    func showLoading()
    func hideLoading()
    func genericError()
    func equalCurrenciesError()
    func updateViewState(success: Bool)
    func showConverted(value: String)
}
