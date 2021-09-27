//
//  Utils.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 27/09/21.
//

import UIKit

final class Utils {
    
    static func showMessage(viewController: UIViewController, title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
