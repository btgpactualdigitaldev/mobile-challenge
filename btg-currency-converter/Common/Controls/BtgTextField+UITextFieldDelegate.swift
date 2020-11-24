//
//  BtgTextField+UITextFieldDelegate.swift
//  Btg
//
//  Created by Paulo Roberto Cremonine Junior on 03/01/20.
//  Copyright © 2020 Btg. All rights reserved.
//
import UIKit

extension BtgTextField : UITextFieldDelegate{
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        if(imputMask == .date){
            return updatedText.count <= 10
        }
        else if(imputMask == .celPhone){
            return updatedText.count <= 15
        }
        else if(imputMask == .cpf){
            return updatedText.count <= 14
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if(requiredMessage != nil){
            self.errorMessage = textField.text!.isEmpty ? requiredMessage : nil
        }
        if(self.errorMessage == nil){
            if(imputMask == .email) {
                self.errorMessage = !textField.text!.isValidEmail ? "E-mail inválido" : nil
            }
            else if(imputMask == .date){
                self.errorMessage = !textField.text!.isValidDate ? "Data inválida" : nil
            }
            else if(imputMask == .celPhone){
                self.errorMessage = !textField.text!.isValidCelPhone ? "Celular inválido" : nil
            }
            else if(imputMask == .cpf){
                self.errorMessage = !textField.text!.isValidCpf ? "CPF inválido" : nil
            }
        }
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.errorMessage = nil
        return true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

}
