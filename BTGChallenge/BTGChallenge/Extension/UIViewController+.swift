//
//  UIViewController+.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 15/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: (()-> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
            guard let cb = completion else { return }
            cb()
        }))

        self.present(alert, animated: true)
    }
}
