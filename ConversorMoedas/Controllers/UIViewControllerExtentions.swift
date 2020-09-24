//
//  UIViewControllerExtentions.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 17/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

extension UIViewController{
    func showMessage(_ title: String, _ message: String){

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
