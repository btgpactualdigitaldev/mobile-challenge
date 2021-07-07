//
//  UIViewController+TextFieldToolBars.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 11/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
import UIKit
import Foundation


extension UIViewController {
    
    func setupTextFields(textFields: [UITextField]) {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30.0)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
    
        toolbar.setItems([flexSpace,doneButton], animated: false)
        toolbar.sizeToFit()
        
        for textField in textFields {
            textField.inputAccessoryView = toolbar
        }
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
}
