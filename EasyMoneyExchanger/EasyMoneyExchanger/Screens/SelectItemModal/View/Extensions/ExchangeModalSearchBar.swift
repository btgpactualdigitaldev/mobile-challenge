//
//  ExchangeModalSearchBar.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 13/12/20.
//

import Foundation
import UIKit
extension ExchangeModalViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter Dictionary
        if searchText.count > 0 && searchText != " "{
//            viewModel?.supportedListSearch = viewModel?.supportedList?.filter {$0.currencyName.contains(searchText) || $0.currencyCode.contains(searchText)}
        } else {

        }
        tableView.reloadData()
    }

    // Disable keyboard on Press Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
