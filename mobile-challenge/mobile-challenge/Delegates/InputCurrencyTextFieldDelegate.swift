//
//  InputCurrencyTextFieldDelegate.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import UIKit

class InputCurrencyTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // Callback function
    var textChanged: (() -> Void) = {}
    var shouldBeginEdit: (() -> Bool) = { return true }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Only accepts currency
        var input = (textField.text ?? "") + string
        
        // Remove every non digit character except decimal separator
        input.removeAll(where: {Double($0.description) == nil && $0.description != Locale.current.decimalSeparator})
        input = input.replacingOccurrences(of: Locale.current.decimalSeparator ?? "", with: ".")
        
        // Max of 15 characters due to Double precision
        return ((string != "" && input.count <= 15) || string == "") && isValidNumber(input) && lessThanTwoDecimals(input)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return shouldBeginEdit()
    }
    
    func isValidNumber(_ string: String) -> Bool {
        return Double(string) != nil
    }
    
    func lessThanTwoDecimals(_ string: String) -> Bool {
        let splitString = string.split(separator: ".")
        return splitString.count <= 1 || (splitString.count > 1 && splitString[1].count < 3)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textChanged()
    }
}
