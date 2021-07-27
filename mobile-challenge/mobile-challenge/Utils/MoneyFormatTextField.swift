//
//  MoneyFormatTextField.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 25/04/21.
//

import UIKit

@IBDesignable
class MoneyFormatTextField: UITextField, UITextFieldDelegate {
    
    
    @IBInspectable var maxLength: Int = 0
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.currencyFormat
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    var cleanText: String {
        get {
            var cleanNumericString: String = ""
            let textFieldString = self.text?.replacingOccurrences(of: " ", with: " ")
            if let textFieldString = textFieldString{
                //Remove $ sign
                var toArray = textFieldString.components(separatedBy: "")
                cleanNumericString = toArray.joined(separator: "")
                
                //Remove .
                toArray = cleanNumericString.components(separatedBy: ".")
                cleanNumericString = toArray.joined(separator: "")
                
                //Change . to ,
                toArray = cleanNumericString.components(separatedBy: ",")
                cleanNumericString = toArray.joined(separator: ".")
            }
            
            return cleanNumericString
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        
        if maxLength > 0 {
            return count <= maxLength
        } else {
            return true
        }
    }
    
}
