//
//  CollectionExtension.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

extension Collection where Self.Element == NSLayoutConstraint {
    func activate() {
        forEach { $0.isActive = true}
    }
}
