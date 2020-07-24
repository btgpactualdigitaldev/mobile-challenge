//
//  UIColor.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(named name: Colors) {
        self.init(named: name.rawValue)!
    }
}
