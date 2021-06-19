//
//  Fonts.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

enum Font: String {
    case regular = "Manrope-Regular"
    case medium = "Manrope-Medium"
    case bold = "Manrope-Bold"

    var name: String {
        return self.rawValue
    }
}

struct FontDescription {
    let font: Font
    let size: CGFloat
    let style: UIFont.TextStyle
}

enum TextStyle {
    ///40pt, Medium
    case display1
    ///20pt, Medium
    case display2
    ///20pt, Bold
    case display3
    ///16pt, Regular
    case display4
    ///14pt, Regular
    case display5
}

extension TextStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .display1:
            return FontDescription(font: .medium, size: 40, style: .largeTitle)
        case .display2:
            return FontDescription(font: .medium, size: 28, style: .title1)
        case .display3:
            return FontDescription(font: .bold, size: 20, style: .title2)
        case .display4:
            return FontDescription(font: .regular, size: 16, style: .headline)
        case .display5:
            return FontDescription(font: .regular, size: 14, style: .footnote)
        }
    }
}

extension TextStyle {
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont.preferredFont(forTextStyle: fontDescription.style)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: fontDescription.style)
        return fontMetrics.scaledFont(for: font)
    }
}
