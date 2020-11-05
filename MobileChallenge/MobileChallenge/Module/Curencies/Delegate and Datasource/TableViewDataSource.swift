//
//  TableViewDataSource.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource{
   
    var currencies: [String: String] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesViewCell.uniqueIdentifier , for: indexPath) as? CurrenciesViewCell
        else{
            return UITableViewCell()
        }

        cell.codeLabel.text = currencies[indexPath.row].key
        cell.nameLabel.text = currencies[indexPath.row].value

        return cell
    }
}
