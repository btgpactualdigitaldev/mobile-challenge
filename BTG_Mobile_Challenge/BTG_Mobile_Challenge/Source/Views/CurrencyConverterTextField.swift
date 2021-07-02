//
//  CurrencyConverterTextField.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyConverterTextField: UITextField {
    
    override var bounds: CGRect {
        didSet {
            setCornerRadius()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 0.1510314941)
        self.textColor = .black
        self.placeholder = "Seu Valor"
        setTextField()
    }
    
    required convenience init?(coder: NSCoder) {
        guard let frame = coder.decodeObject(forKey: "frame") as? CGRect else {
            return nil
        }
        self.init(frame: frame)
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = self.frame.height * 0.2
    }
    
    private func setTextField() {
        keyboardType = .numberPad
        textAlignment = .center
        borderStyle = .roundedRect
    }
    
}
