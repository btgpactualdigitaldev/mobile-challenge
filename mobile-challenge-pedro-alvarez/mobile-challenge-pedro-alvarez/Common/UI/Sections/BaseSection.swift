//
//  BaseSection.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class BaseSection: TableViewSectionProtocol {
    
    var builders: [TableViewCellBuilderProtocol]
    
    init(builders: [TableViewCellBuilderProtocol],
         tableView: UITableView) {
        self.builders = builders
        for builder in builders {
            builder.registerCell(tableView: tableView)
        }
    }
    func heightForHeader() -> CGFloat {
        return 0
    }
    
    func headerView() -> UIView? {
        return nil
    }
    
    func numberOfRows() -> Int {
        return builders.count
    }
    
    func cellHeightFor(indexPath: IndexPath) -> CGFloat {
        return builders[indexPath.row].cellHeight()
    }
    
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        return builders[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView)
    }
}
