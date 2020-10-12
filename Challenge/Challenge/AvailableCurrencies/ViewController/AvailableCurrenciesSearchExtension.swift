//
//  AvailableCurrenciesSearchExtension.swift
//  Challenge
//
//  Created by Eduardo Raffi on 11/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

extension AvailableCurrenciesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            filteredList = []
            theView.tableView.reloadData()
            return
        }
        filteredList = []
        isSearching = true
        var list: [Dictionary<String, String>.Element] = []
        let _: [Dictionary<String, String>.Element] = orderedList.map({ key, value in
            if key.lowercased().contains(searchText.lowercased()) {
                list.append((key, value))
            }
            else if value.lowercased().contains(searchText.lowercased()) {
                list.append((key, value))
            }
            return (key, value)
        })
        filteredList = list
        theView.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        filteredList = []
        theView.tableView.reloadData()
    }

}
