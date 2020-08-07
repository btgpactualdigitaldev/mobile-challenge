//
//  FloatViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 07/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit

class FloatViewController: UIViewController {
    fileprivate var contentBottomConstraint: NSLayoutConstraint?
    var contentPaddingBottom: CGFloat = 8
    
    func createKeyboardObserver(contentBottomConstraint: NSLayoutConstraint) {
        self.contentBottomConstraint = contentBottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        contentBottomConstraint!.constant = keyboardSize + contentPaddingBottom
    }

    @objc func keyboardWillDisappear(sender: NSNotification) {
        contentBottomConstraint!.constant = contentPaddingBottom
    }
}
