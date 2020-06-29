//
//  UIColor+Extension.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static let currencyButtonBackgroundColor: UIColor = UIColor(rgb: 0x00994c)
    static let currencyButtonLayerColor: UIColor = UIColor(rgb: 0xa8bf4e)
    static let currencyButtonFontColor: UIColor = UIColor(rgb: 0xa8bf4e)
    
    static let convertButtonBackgroundColor: UIColor = UIColor(rgb: 0x00cccc)
    static let convertButtonLayerColor: UIColor = UIColor(rgb: 0xe0e0e0)
    static let convertButtonFontColor: UIColor = UIColor(rgb: 0xffffff)
    
    static let currencyTableViewCellLayerColor: UIColor = UIColor(rgb: 0xa8bf4e)
    static let currencyTableViewCellBackgrouncColor: UIColor = UIColor(rgb: 0x00994c)
    static let currencyLblColor: UIColor = UIColor(rgb: 0xa8bf4e)
    
    static let convertionButtonDeactivactedBackground: UIColor = UIColor(rgb: 0xccffff)
    
    static let convertionBackGroundColor: UIColor = UIColor(rgb: 0x00994c)
    
    static let currencyMainButtonBackgroundColor: UIColor = UIColor(rgb: 0x00cc66)
}
