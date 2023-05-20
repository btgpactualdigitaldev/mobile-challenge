//
//  UIAlertController.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    
    // MARK: - Public Methods
    
    
    static func showOkAlert(withTitle title: String?, message: String, forViewController viewController: UIViewController, okHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okHandler))
           viewController.present(alert, animated: true, completion: nil)
       }
    
}
