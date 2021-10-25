//
//  UIColorExtension.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import Foundation
import UIKit


extension UIColor {
    
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
}
