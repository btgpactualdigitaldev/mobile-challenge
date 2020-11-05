//
//  TextFieldDelegate.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation
import UIKit

protocol ChangeTextFieldDelegate: NSObject {
    func didChangeText()
}

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var changeTextFieldDelegate: ChangeTextFieldDelegate?
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count ?? 0 >= 10 {
            textField.text?.removeLast()
            return
        }
        
        changeTextFieldDelegate?.didChangeText()
    }
}
