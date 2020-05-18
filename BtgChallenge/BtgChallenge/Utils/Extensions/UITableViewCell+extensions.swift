//
//  UITableViewCell+extensions.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 14/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reusableIdentifier: String {
        return String(describing: type(of: self))
    }
}
