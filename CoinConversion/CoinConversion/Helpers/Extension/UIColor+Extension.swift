//
//  ExtensionColoring.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

extension UIColor {
    static var colorBackground: UIColor {
        return UIColor(hexadecimal: 0xEBE9D7)
    }
    
    static var colorGrayPrimary: UIColor {
        return UIColor(hexadecimal: 0x383743)
    }
    
    static var colorCharcoalGrey: UIColor {
        return UIColor(hexadecimal: 0x373843)
    }
    
    static var colorGreenyBlue: UIColor {
        return UIColor(hexadecimal: 0x57BBBC)
    }
    
    static var colorDarkishPink: UIColor {
        return UIColor(hexadecimal: 0xDE4772)
    }
    
    static var colorWarmGrey: UIColor {
        return UIColor(hexadecimal: 0x8C8D8D)
    }
    
    static var colorGrayLighten60: UIColor {
        return UIColor(hexadecimal: 0xdbdbdb)
    }
    
    static var colorGrayLighten70: UIColor {
        return UIColor(hexadecimal: 0xfcfcfc)
    }
    
    static var colorSpringGreen: UIColor {
        return UIColor(hexadecimal: 0x00FF7F)
    }
    
    static var colorDarkRed: UIColor {
        return UIColor(hexadecimal: 0x8B0000)
    }
}

protocol Coloring { }

extension Coloring where Self: UIColor {
    
    init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    init(hexadecimal: Int) {
        
        self.init(red:(hexadecimal >> 16) & 0xff, green:(hexadecimal >> 8) & 0xff, blue:hexadecimal & 0xff)
    }
}
extension UIColor : Coloring { }
