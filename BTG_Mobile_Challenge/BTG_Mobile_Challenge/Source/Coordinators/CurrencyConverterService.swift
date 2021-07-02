//
//  CurrencyConverterService.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation

protocol CurrencyConverterService: Coordinator {
    func changeCurrency(selectedCase: SelectCase, response: CurrencyResponseFromList)
    func changeFinished()
}
