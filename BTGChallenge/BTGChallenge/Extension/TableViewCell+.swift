//
//  TableViewCell+.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

extension UITableViewCell {
    @nonobjc static var reusableIdentifier: String {
        return String(describing: self)
    }
}
