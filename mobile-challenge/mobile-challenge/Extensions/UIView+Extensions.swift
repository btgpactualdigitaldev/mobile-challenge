//
//  UIView+Extension.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 24/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(centerX: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
                centerY: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
                top: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
                left: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
                right: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
                bottom: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX { self.centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant).isActive = true }
        if let centerY = centerY { self.centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant).isActive = true }
        if let top = top { self.topAnchor.constraint(equalTo: top.anchor, constant: top.constant).isActive = true }
        if let left = left { self.leftAnchor.constraint(equalTo: left.anchor, constant: left.constant).isActive = true }
        if let right = right { self.rightAnchor.constraint(equalTo: right.anchor, constant: -right.constant).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant).isActive = true }
        if let width = width { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
        if let height = height { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
    }
}
