//
//  UITableView+DequeueReusableCell.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 28/10/21.
//

import UIKit

fileprivate extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as! Cell
    }
}
