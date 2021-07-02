//
//  CurrencyListViewModeling.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import Foundation

protocol CurrencyListViewModeling {
    var delegate: CurrencyListViewModelDelegate? { get set }
    
    var newCurrencyCode: String { get }
    var newCurrencyName: String { get }
    
    func swapCurrencies(newCode: String, newName: String)
}
