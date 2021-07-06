//
//  CurrencySearchBarDelegate.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 30/10/20.
//

import UIKit

class CurrencySearchBarDelegate: NSObject, UISearchBarDelegate {
    
    
    var viewModel: CurrencyListViewModel
    var reloadToApplyFilter: (() -> Void)?
    var didFilteredCurrencies: (([Currency]) -> Void)?
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredData = searchText.isEmpty ? viewModel.currencies : viewModel.currencies.filter( {($0.code.localizedCaseInsensitiveContains(searchText)) || ($0.name.localizedCaseInsensitiveContains(searchText))})
        
       didFilteredCurrencies?(filteredData)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let scopeString = searchBar.scopeButtonTitles?[selectedScope] else { return }
        
        let currencyFilterSearchBar = CurrencyFilterSearchBar(rawValue: scopeString)
        
        switch currencyFilterSearchBar {
        
        case .nome:
            self.viewModel.currencies = self.viewModel.currencies.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .codigo:
            self.viewModel.currencies = self.viewModel.currencies.sorted { $0.code.lowercased() < $1.code.lowercased() }
        default:
            break
            
        }
        
        reloadToApplyFilter?()
    }
    
    
}
