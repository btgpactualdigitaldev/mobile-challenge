//
//  AlertMessage.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 25/04/21.
//

import Foundation
import UIKit

public class AlertMessage {
    public static func showOk(title:String, message:String = "") {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
        })
        
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {return }
            
            guard var topController = window.rootViewController else {return}
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if !(topController.isKind(of: UIAlertController.self)) {
                topController.present(alert, animated: true){}
            }
        }
    }
}
