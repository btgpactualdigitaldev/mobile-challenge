//
//  UIFont+SFProText.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func sfPro(_ style: Style) -> UIFont {
        guard let font = UIFont(name: style.name, size: style.size) else {
            fatalError("""
                Failed to load the "\(style.name)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
    
    
    
    enum Style {
        case largeTitle(_ variation: Variation)
        case body(_ variation: Variation)
        case title1(_ variation: Variation)
        case title3(_ variation: Variation)
        case subheadline(_ variation: Variation)
        
        var name: String {
            switch self {
            case .largeTitle(let variation): return "SFProDisplay-Bold\(variation.suffix)"
            case .body(let variation): return "SFProText-Semibold\(variation.suffix)"
            case .title1(let variation): return "SFProDisplay-Bold\(variation.suffix)"
            case .title3(let variation): return "SFProDisplay-Regular\(variation.suffix)"
            case .subheadline(let variation): return "SFProText-Regular\(variation.suffix)"
            }
        }
        
        var size: CGFloat {
            switch self {
            case .largeTitle: return 34
            case .body: return 17
            case .title1: return 28
            case .title3: return 20
            case .subheadline: return 15
            }
        }
        
        enum Variation {
            case plain
            case italic
            
            var suffix: String {
                switch self {
                case .italic: return "Italic"
                case .plain: return ""
                }
            }
        }
    }
}
