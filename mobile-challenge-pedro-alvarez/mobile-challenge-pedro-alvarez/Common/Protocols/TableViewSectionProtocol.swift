//
//  TableViewSectionProtocol.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol TableViewSectionProtocol {
    var builders: [TableViewCellBuilderProtocol] { get set }
    
    func numberOfRows() -> Int
    func heightForHeader() -> CGFloat
    func headerView() -> UIView?
    func cellHeightFor(indexPath: IndexPath) -> CGFloat
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}
