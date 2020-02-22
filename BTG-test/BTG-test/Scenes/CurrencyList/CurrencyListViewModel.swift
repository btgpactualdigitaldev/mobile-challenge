//
//  CurrencyListViewModel.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import Foundation

class CurrencyListViewModel {
    
    var currencies: [Currency]
    var filtered = [Currency]()
    
    var isFiltering = false
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func filter(text: String) {
        let textToFilter = text.folding(options: .diacriticInsensitive, locale: NSLocale.current)
        if !textToFilter.isEmpty {
            filtered = currencies.filter({
                $0.title.lowercased().contains(textToFilter.lowercased()) || $0.description?.lowercased().contains(textToFilter.lowercased()) ?? false
            })
            isFiltering = true
        } else {
            isFiltering = false
        }
    }
}
