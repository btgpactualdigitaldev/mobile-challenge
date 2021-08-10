//
//  UIView+Anchors.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

extension UIView {
	func anchor(
		top: (NSLayoutYAxisAnchor, CGFloat)? = nil,
		right: (NSLayoutXAxisAnchor, CGFloat)? = nil,
		left: (NSLayoutXAxisAnchor, CGFloat)? = nil,
		bottom: (NSLayoutYAxisAnchor, CGFloat)? = nil,
		centerX: (NSLayoutXAxisAnchor, CGFloat)? = nil,
		centerY: (NSLayoutYAxisAnchor, CGFloat)? = nil,
		height: CGFloat? = nil,
		width: CGFloat? = nil) {
		
		self.translatesAutoresizingMaskIntoConstraints = false
		if let top = top { self.topAnchor.constraint(equalTo: top.0, constant: top.1).isActive = true }
		if let left = left { self.leftAnchor.constraint(equalTo: left.0, constant: left.1).isActive = true }
		if let right = right { self.rightAnchor.constraint(equalTo: right.0, constant: -right.1).isActive = true }
		if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom.0, constant: -bottom.1).isActive = true }
		if let centerX = centerX { self.centerXAnchor.constraint(equalTo: centerX.0, constant: centerX.1).isActive = true }
		if let centerY = centerY { self.centerYAnchor.constraint(equalTo: centerY.0, constant: centerY.1).isActive = true }
		if let height = height { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
		if let width = width { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
	}
}
