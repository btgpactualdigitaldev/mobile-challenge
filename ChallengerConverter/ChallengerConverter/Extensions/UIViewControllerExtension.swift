//
//  UIViewControllerExtension.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import Foundation
import UIKit


extension UIViewController {
    func showAlert(_ title: String,
                   _ message: String = "",
                   _ buttonTitle: String = "Ok",
                   with completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in completion?() })
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
}
