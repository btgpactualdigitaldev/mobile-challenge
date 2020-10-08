//
//  ViewUtils.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import UIKit

class ViewUtils {
    
    private static let alert = UIAlertController(title: nil, message: NSLocalizedString("please_wait", comment: ""), preferredStyle: .alert)
    private static var isLoadingHidden = false
     
    static func alert(_ viewController: UIViewController, title: String? = nil, _ msg: String, btnLabel: String? = nil, completion: (() -> ())? = nil, onOK: (() -> ())? = nil) {
        DispatchQueue.main.async {
            let cancelButton = UIAlertAction(title: btnLabel ?? "OK", style: .default, handler: { action in
                onOK?()
            })
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(cancelButton)
            viewController.present(alert, animated: true, completion: completion)
        }
    }
    
    static func showLoading(viewController: UIViewController) {
        DispatchQueue.main.async {
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            if !isLoadingHidden {
                alert.view.addSubview(loadingIndicator)
                viewController.present(alert, animated: true, completion: nil)
            }
            
            isLoadingHidden = false
        }
    }
    
    static func hideLoading() {
        DispatchQueue.main.async {
            alert.dismiss(animated: true, completion: nil)
            isLoadingHidden = true
        }
    }
}
