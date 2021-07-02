//
//  UIView+Extension.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import UIKit

extension UIView {
    
    func addAnchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, widht: CGFloat?, height: CGFloat?) {
                
        if let anchor = top {
            topAnchor.constraint(equalTo: anchor, constant: padding.top).isActive = true
        }
        
        if let anchor = leading {
            leadingAnchor.constraint(equalTo: anchor, constant: -(padding.left)).isActive = true
        }
        
        if let anchor = trailing {
            trailingAnchor.constraint(equalTo: anchor, constant: padding.right).isActive = true
        }
        
        if let anchor = bottom{
            bottomAnchor.constraint(equalTo: anchor, constant: -(padding.bottom)).isActive = true
        }
        
        if let width = widht {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func addContraintsRelative(to View: UIView, with Multiplier: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: Multiplier).isActive = true
        heightAnchor.constraint(equalTo: View.heightAnchor, multiplier: Multiplier).isActive = true
    }
}
