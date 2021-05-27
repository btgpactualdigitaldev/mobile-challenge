//
//  UIViewController+Extensions.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 12/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(title: String = "", message:String) {
        var showTitle = "Atenção!"
        
        if !title.isEmpty {
            showTitle = title
        }
        
        let alert = UIAlertController(title: showTitle, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
