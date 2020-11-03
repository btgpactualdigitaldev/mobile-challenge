//
//  Style.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

enum Style {
    // MARK: Spaces
    static let defaultSpace: CGFloat = 24
    static let defaultTop: CGFloat = defaultSpace
    static let defaultBottom: CGFloat = -defaultSpace
    static let defaultLeading: CGFloat = defaultSpace
    static let defaultTrailing: CGFloat = -defaultSpace
    
    static let defaultCloseSpace: CGFloat = 8
    static let defaultCloseTop: CGFloat = defaultCloseSpace
    static let defaultCloseBottom: CGFloat = -defaultCloseSpace
    static let defaultCloseLeading: CGFloat = defaultCloseSpace
    static let defaultCloseTrailing: CGFloat = -defaultCloseSpace
    
    static let defaultRadius: CGFloat = 8
    
    // MARK: Font
    static let defaultFont: UIFont = UIFont.systemFont(ofSize: 12)
    static let highlightFont: UIFont = UIFont.systemFont(ofSize: 20)
    
    // MARK: Colors
    static let defaultPrimaryTextColor: UIColor = .white
    static let defaultSecondaryTextColor: UIColor = .lightGray
    static let veryDarkGray: UIColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
}
