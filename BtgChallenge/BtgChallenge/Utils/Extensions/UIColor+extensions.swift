//
//  UIColor+extensions.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

extension UIColor {
    
    @nonobjc class var lightGray: UIColor {
        return UIColor(red: 251, green: 250, blue: 250)
    }
    
    @nonobjc class var softGreen: UIColor {
        return UIColor(red: 107, green: 196, blue: 177)
    }
    
    @nonobjc class var softBlue: UIColor {
        return UIColor(red: 116, green: 191, blue: 232)
    }
    
    @nonobjc class var darkBlue: UIColor {
        return UIColor(red: 32, green: 87, blue: 150)
    }
    
    @nonobjc class var elevationGray: UIColor {
        return UIColor(red: 219, green: 223, blue: 227)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(Double(red) / 255.0),
                  green: CGFloat(Double(green) / 255.0),
                  blue: CGFloat(Double(blue) / 255.0),
                  alpha: 1)
    }
    
}
