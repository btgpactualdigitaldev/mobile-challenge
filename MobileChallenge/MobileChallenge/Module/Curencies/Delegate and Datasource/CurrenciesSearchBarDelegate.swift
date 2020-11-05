//
//  CurrenciesSearchBarDelegate.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import UIKit

protocol SeachBarFilterDelegate: NSObject {
    func didSearchCurrency(currencies: [String: String])
}

class CurrenciesSearchBarDelegate: NSObject, UISearchBarDelegate {

    var currencies: [String: String] = [:]
    var seachBarFilterDelegate: SeachBarFilterDelegate?
    
    init(currencies: [String: String]){
        self.currencies = currencies
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filteredData = searchText.isEmpty ? currencies :
            currencies.filter({($0.value.localizedCaseInsensitiveContains(searchText))})
        
        seachBarFilterDelegate?.didSearchCurrency(currencies: filteredData)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        seachBarFilterDelegate?.didSearchCurrency(currencies: currencies)
    }
}
