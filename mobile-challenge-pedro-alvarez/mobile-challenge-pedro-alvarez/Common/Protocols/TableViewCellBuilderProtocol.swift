//
//  TableViewCellBuilderProtocol.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol TableViewCellBuilderProtocol {
    func registerCell(tableView: UITableView)
    func cellHeight() -> CGFloat
    func cellAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}
