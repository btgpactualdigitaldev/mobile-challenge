//
//  UITableView+ReloadData.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 29/10/21.
//

import UIKit

extension UITableView {
    public func reloadData(animated: Bool) {
        DispatchQueue.main.async {
            if animated {
                UIView.animate(withDuration: 0.5) {
                    self.alpha = 0.0
                    self.reloadData()
                    self.alpha = 1.0
                }
            } else {
                self.reloadData()
            }
        }
    }
}
