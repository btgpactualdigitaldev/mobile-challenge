//
//  UIViewController+Extension.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 05/10/20.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String = "", message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
