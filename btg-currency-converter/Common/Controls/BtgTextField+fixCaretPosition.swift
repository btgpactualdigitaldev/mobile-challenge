//
//  Btg+fixCaretPosition.swift
//  Btg
//
//  Created by Paulo Roberto Cremonine Junior on 26/12/19.
//  Copyright © 2019 Btg. All rights reserved.
//

import UIKit

extension UITextField {
    func fixCaretPosition() {
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
}
