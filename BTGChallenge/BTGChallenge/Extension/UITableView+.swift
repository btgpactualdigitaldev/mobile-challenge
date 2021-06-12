//
//  UITableView+.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNibForTableViewCell<T: UITableViewCell>(_: T.Type) {
        self.register(UINib(nibName: T.reusableIdentifier, bundle: nil),
                      forCellReuseIdentifier: T.reusableIdentifier)
    }
}
