//
//  Extensions.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 23/05/21.
//

import Foundation
import UIKit

// Initial idea from: https://stackoverflow.com/questions/39807386/limit-text-field-to-one-decimal-point-input-numbers-only-and-two-characters-af
extension String {
    private static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        return formatter
    }()

    private var decimalSeparator: String {
        return String.decimalFormatter.decimalSeparator ?? ","
    }

    func isValidDecimal(maximumFractionDigits:Int) -> Bool {
        guard self.isEmpty == false else {
            return true
        }

        // Check if valid decimal
        if let _ = String.decimalFormatter.number(from: self) {
            let numberComponents = self.components(separatedBy: decimalSeparator)
            let fractionDigits = numberComponents.count == 2 ? numberComponents.last ?? "" : ""
            
            return fractionDigits.count <= maximumFractionDigits
        }

        return false
    }
}

// Extrated from https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
