//
//  Helper.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import UIKit

class Helper {
    
    static func alertController(_ title: String, message: String, handlerAction: ((UIAlertAction) -> Void)? = nil) {
        Thread.isMainThread ? createAlertController(title, message: message, handlerAction: handlerAction) : DispatchQueue.main.async { createAlertController(title, message: message, handlerAction: handlerAction) }
    }
    
    static func createAlertController(_ title: String, message: String, handlerAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handlerAction)
        alertController.addAction(okAction)
        getPresentedViewController().present(alertController, animated: true, completion: nil)
    }
    
    static func getPresentedViewController() -> UIViewController {
        var viewController = UIViewController()
        if var rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = rootViewController.presentedViewController {
                rootViewController = presentedViewController
            }
            viewController = rootViewController
        }
        return viewController
    }
}
