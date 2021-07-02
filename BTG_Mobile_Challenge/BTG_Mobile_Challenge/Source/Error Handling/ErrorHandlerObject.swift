//
//  ErrorHandlerObject.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import Foundation
import UIKit

final class ErrorHandlerObject {
    
    private weak var controller: UIViewController? {
        
        let baseController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController
        
        if let navigationController = baseController as? UINavigationController {
            return navigationController.visibleViewController
        }
        
        if let presented = baseController?.presentedViewController {
            return presented
        }
        return baseController
    }
    
    internal func genericErrorHandling(title: String, message: String) {
        presentAlertController(title: title, message: message)
    }
    
    private func presentAlertController(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert).makeErrorMessage(with: message)
            
            self.controller?.present(alertController, animated: true, completion: nil)
        }
    }
}

