//
//  CurrencyListTableViewDelegate.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import UIKit

class CurrencyListTableViewDelegate: NSObject, UITableViewDelegate {
    
    var didSelectedRowAt: ((Int) -> Void) = { _ in }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedRowAt(indexPath.row)
    }
}
