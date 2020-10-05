//
//  UIFont.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 04/10/20.
//

import UIKit

extension UIFont {
    func bold() -> UIFont {
        guard let newDescriptor = fontDescriptor.withSymbolicTraits(.traitBold) else {
            return self
        }

        return UIFont(descriptor: newDescriptor, size: 0)
    }
}
