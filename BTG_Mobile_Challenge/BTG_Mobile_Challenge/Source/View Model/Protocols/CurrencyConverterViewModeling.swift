//
//  CurrencyConverterViewModeling.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation

enum SelectCase {
    case toBeConverted
    case beConvertedFrom
}

protocol CurrencyConverterViewModeling {
    var delegate: CurrencyConverterViewModelDelegate? { get set }
        
    var fromCurrencyCode: String { get }
    var fromCurrencyName: String { get }
    var fromCurrencyValue: String? { get set }
    
    var toCurrencyCode: String { get }
    var toCurrencyName: String { get }
    var toCurrencyValue: String? { get }
    
    func fetchCurrencyLiveQuote()
    func fetchCurrencyListQuote()
    
    func convert(amount: String) -> String
    func convertFromUSD(amount: Double) -> String
    func convertToUSD(amount: Double) -> String
    func swapCurrencies()
    func pickCurrencies(selectCase: SelectCase)
}
