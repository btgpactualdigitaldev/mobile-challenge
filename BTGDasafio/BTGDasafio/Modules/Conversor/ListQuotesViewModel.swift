//
//  ListQuotesViewModel.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 29/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import Foundation

class ListQuotesViewModel {
    private var currencyList: [Currency]?

    init(currencyList:[Currency]?) {
        self.currencyList = currencyList
    }
}


extension ListQuotesViewModel {
    var numberOfRows: Int? { return currencyList?.count ?? 0 }
    var cellIdentifier: String { return "quoteCell" }
    
    func cellTitle(at index: Int) -> String? {
        guard let currency = currency(at: index) else { return nil }
        return currency.currency
    }
    func currency(at index: Int) -> Currency? {
        guard let currencyList = currencyList,
            index < currencyList.count else { return nil }
        return currencyList[index]
    }
}
