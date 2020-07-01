//
//  UIAlertController.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    static func showOkAlert(withTitle title: String?, message: String, forViewController viewController: UIViewController, okHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
           viewController.present(alert, animated: true, completion: nil)
       }
    
}
