//
//  CurrencyListTableViewCellBuilder.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListTableViewCellBuilder: TableViewCellBuilderProtocol {
    
    private(set) var currencyAttrString: NSAttributedString
    
    init(currencyAttrString: NSAttributedString) {
        self.currencyAttrString = currencyAttrString
    }
    
    private let height: CGFloat = 60
    
    func registerCell(tableView: UITableView) {
        tableView.registerCell(cellType: CurrencyListTableViewCell.self)
    }

    func cellHeight() -> CGFloat {
        return height
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: CurrencyListTableViewCell.self)
        cell.setup(currencyAttrString: currencyAttrString)
        
        return cell
    }
    
}
