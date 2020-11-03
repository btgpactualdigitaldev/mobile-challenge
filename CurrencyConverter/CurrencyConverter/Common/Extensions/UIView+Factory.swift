//
//  UIView+Factory.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

extension UIView {
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        clipsToBounds = true
        return self
    }
    
    @discardableResult
    func useConstraint() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
