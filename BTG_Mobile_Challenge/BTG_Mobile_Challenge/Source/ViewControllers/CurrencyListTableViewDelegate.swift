//
//  CurrencyListTableViewDelegate.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import UIKit

final class CurrencyListTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var didSelectCell: (CurrencyListUITableViewCell) -> Void?
    
    init(_ didSelectCell: @escaping (CurrencyListUITableViewCell) -> Void) {
        self.didSelectCell = didSelectCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let currencyCell = tableView.cellForRow(at: indexPath) as? CurrencyListUITableViewCell else {
            return
        }
        didSelectCell(currencyCell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}
