//
//  CurrencyListViewModel.swift
//  iOSBTG
//
//  Created by Filipe Merli on 12/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

enum CurrencyList {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let currencies: CurrenciesListModel
            
        }
        
        struct ViewModel {
            let currencies: [String : String]
            var orderedList: [String] = []
            
            init(currencies: CurrenciesListModel) {
                self.currencies = currencies.currencies
                orderedList = orderList(list: self.currencies)
            }
            
            private func orderList(list: [String : String]) -> [String] {
                let alphabetical = list.sorted(by: { $0.0 < $1.0 })
                var result: [String] = []
                for element in alphabetical {
                    result.append("\(element.key): \(element.value)")
                }
                return result
            }
        }
    }
    
}
