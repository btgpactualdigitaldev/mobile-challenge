//
//  NumberTextField.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import UIKit

class NumberTextField: UITextField {
    
    var currencyCode: String  = "" {
        didSet {
            updateValue( text: self.text ?? "`" )
        }
    }
    
    var didUpdateValue: ((Double)-> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension NumberTextField {
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        
        updateValue( text: textField.text! )
    }
    
    func updateValue(text: String) {
        var amountWithPrefix = text
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, amountWithPrefix.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        let number: NSNumber = NSNumber(value: (double / 100))
        
        self.text = number.doubleValue.toCyrrency(currencyCode: currencyCode)
        didUpdateValue?(number.doubleValue)
    }
}
