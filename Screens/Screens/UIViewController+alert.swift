//
//  UIViewController+alert.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ error: Error) {
        let ok = UIAlertAction(title: "Ok", style: .default)
        let alert = UIAlertController(title: "An error has occurred...", message: "\(error)", preferredStyle: .alert)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
