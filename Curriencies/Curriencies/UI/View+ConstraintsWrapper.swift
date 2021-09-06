//
//  View+ConstraintsWrapper.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

import UIKit

extension UIView {
    @discardableResult
    func make(_ anchor: NSLayoutConstraint.Attribute,
              equalTo view: UIView,
              attribute: NSLayoutConstraint.Attribute? = nil,
              multipliedBy: CGFloat = 1,
              constant: CGFloat = 0) -> Self {
        NSLayoutConstraint(item: self,
                           attribute: anchor,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: attribute ?? anchor,
                           multiplier: multipliedBy,
                           constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func make(_ anchors: [NSLayoutConstraint.Attribute],
              equalTo view: UIView,
              attribute: NSLayoutConstraint.Attribute? = nil,
              multipliedBy: CGFloat = 1,
              constant: CGFloat = 0) -> Self {
        anchors.forEach { anchor in
            NSLayoutConstraint(item: self,
                               attribute: anchor,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: attribute ?? anchor,
                               multiplier: multipliedBy,
                               constant: constant).isActive = true
        }
        return self
    }
    
    @discardableResult
    func make(_ anchor: NSLayoutConstraint.Attribute,
              equalTo: CGFloat = 0) -> Self {
        NSLayoutConstraint(item: self,
                           attribute: anchor,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: anchor,
                           multiplier: 1,
                           constant: equalTo).isActive = true
        return self
    }
    
    @discardableResult
    func make(_ anchors: [NSLayoutConstraint.Attribute],
              equalTo: CGFloat = 0) -> Self {
        anchors.forEach { anchor in
            NSLayoutConstraint(item: self,
                               attribute: anchor,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: anchor,
                               multiplier: 1,
                               constant: equalTo).isActive = true
        }
        return self
    }
}
