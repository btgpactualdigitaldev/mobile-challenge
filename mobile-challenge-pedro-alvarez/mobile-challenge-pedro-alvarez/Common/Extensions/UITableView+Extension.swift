//
//  UITableView+Extension.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

extension UITableView {
    
    func assignProtocols(to output: TableViewOutput) {
        DispatchQueue.main.async {
            self.delegate = output
            self.dataSource = output
        }
    }
    
    func registerCell<T: UITableViewCell>(cellType: T.Type) {
        DispatchQueue.main.async {
            self.register(cellType, forCellReuseIdentifier: T.defaultReuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, type: T.Type) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
        return cell
    }
}
