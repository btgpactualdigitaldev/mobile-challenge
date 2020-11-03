//
//  ListStyle.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

extension Style {
    enum List {
        static let title: String = "Currency"
        static let closeText: String = "OK"
        static let emptySearch: String = "No currency found"
        static let searchHeight: CGFloat = 70
        static let cellHeight: CGFloat = 50
        static let tableViewSeparatorInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: Style.defaultCloseLeading, bottom: 0, right: 0)
        static let tableViewInset: UIEdgeInsets = UIEdgeInsets(top: Style.defaultCloseTop,
                                                               left: 0,
                                                               bottom: abs(Style.defaultCloseBottom),
                                                               right: 0)
    }
}
