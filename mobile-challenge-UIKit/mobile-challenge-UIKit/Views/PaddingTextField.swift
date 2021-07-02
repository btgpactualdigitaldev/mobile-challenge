//
//  PaddingTextField.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

class PaddingTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: DesignSystem.TextField.padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: DesignSystem.TextField.padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: DesignSystem.TextField.editingPadding)
    }
}
