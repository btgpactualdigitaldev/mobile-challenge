//
//  UITableView+Extension.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
