//
//  SelectCurrencyViewModel.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 23/11/20.
//


public struct SelectCurrencyViewModel {
    let source: String
    let description: String
    
    init(source: String, description: String) {
        self.source = source
        self.description = description
    }
}
