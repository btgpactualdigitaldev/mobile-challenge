//
//  View+AddSubviews.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
