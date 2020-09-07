//
//  NSLayoutConstraint+Extension.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 03/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutYAxisAnchor {
    func anchor(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat? = nil) {
        self.constraint(equalTo: anchor, constant: constant ?? 0.0).isActive  = true
    }
}

extension NSLayoutXAxisAnchor {
    
    func anchor(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat? = nil) {
        self.constraint(equalTo: anchor, constant: constant ?? 0.0).isActive  = true
    }
}

extension NSLayoutDimension {
    func anchor(_ constant: CGFloat) {
        self.constraint(equalToConstant: constant).isActive = true
    }
}
