//
//  DesignSystem.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

/**
 Class for centralizing the design patterns in one place.
 All it's properties should be static.
 */
class DesignSystem {
    
    /// Padding from the LayoutMarguinsGuide to the UI elements
    static let marginsPadding: CGFloat = 15
    static let internalPadding: CGFloat = 10
    
    /// Color palett base on: https://colorhunt.co/palette/264850
    struct Color {
        static var primary: UIColor = #colorLiteral(red: 0.168627451, green: 0.1807843137, blue: 0.2901960784, alpha: 1)
        static var darkPrimary: UIColor = #colorLiteral(red: 0.1037813147, green: 0.1110218716, blue: 0.178600402, alpha: 1)
        static var secondary: UIColor = #colorLiteral(red: 0.9098039216, green: 0.2705882353, blue: 0.2705882353, alpha: 1)
        static var tertiary: UIColor = #colorLiteral(red: 0.5647058824, green: 0.2156862745, blue: 0.2862745098, alpha: 1)
        static var quaternary: UIColor = #colorLiteral(red: 0.3254901961, green: 0.2078431373, blue: 0.2901960784, alpha: 1)
        static var moneySign: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        static var white: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    struct Button {
        static func getWidth(view: UIView) -> CGFloat {
            return view.frame.width/3
        }
        
        static func getHeight(view: UIView) -> CGFloat {
            return view.frame.width/4
        }
        
        static func getCornerRadius(view: UIView) -> CGFloat {
            return getHeight(view: view)/6
        }
    }
}
