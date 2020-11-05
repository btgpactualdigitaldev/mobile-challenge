//
//  TableViewDelegate.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import Foundation
import UIKit

protocol SelectedCellDelegate: NSObject {
    func didSelectedCell(currencyCode: String)
}

class TableViewDelegate: NSObject, UITableViewDelegate{
    
    var currencies: [String: String] = [:]
    
    weak var selectedCellDelegate: SelectedCellDelegate?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellDelegate?.didSelectedCell(currencyCode: currencies[indexPath.row].key)
    }
}
