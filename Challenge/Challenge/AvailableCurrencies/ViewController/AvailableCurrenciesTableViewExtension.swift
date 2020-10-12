//
//  AvailableCurrenciesTableViewExtension.swift
//  Challenge
//
//  Created by Eduardo Raffi on 11/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

let cellId = "availableCell"

extension AvailableCurrenciesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching {
            return orderedList.count
        }
        else {
            return filteredList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AvailableCurrencyCell
        cell.backgroundColor = indexPath.row % 2 != 0 ? .lightGray : .white
        if !isSearching {
            cell.currencyCode.text = orderedList[indexPath.row].key
            cell.currencyName.text = orderedList[indexPath.row].value
        }
        else {
            cell.currencyCode.text = filteredList[indexPath.row].key
            cell.currencyName.text = filteredList[indexPath.row].value
        }
        return cell
    }
    
    
}
