//
//  SimpleAlert.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 30/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in

        }))
        self.present(alert, animated: true, completion: nil)
    }
}
