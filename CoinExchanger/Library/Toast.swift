//
//  Taost.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 15/10/19.
//

import UIKit

class Toast {
    /// Spacing constant
    static let space: CGFloat = 16
    
    /// Show toast notification in the most superview
    class func show(message: String) {
        var window: UIWindow?
        
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows[0]
        } else {
            window = UIApplication.shared.keyWindow
        }
        
        if var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            Toast.show(message: message, controller: topController)
        }
    }
    
    /// Show toast notification in the view
    class func show(message: String, controller: UIViewController) {
        let toastContainer = UIView()
        toastContainer.alpha = 0
        toastContainer.backgroundColor = .black
        toastContainer.clipsToBounds  =  true
        toastContainer.isUserInteractionEnabled = false
        toastContainer.layer.cornerRadius = 4
        toastContainer.layer.shadowRadius = 4

        let toastLabel = UILabel()
        toastLabel.adjustsFontSizeToFitWidth = true
        toastLabel.clipsToBounds  =  true
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.numberOfLines = 1
        toastLabel.text = message
        toastLabel.textAlignment = .left
        toastLabel.textColor = UIColor.white
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let sh = controller.view.safeAreaInsets.bottom/2

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal,
                                    toItem: toastContainer, attribute: .leading, multiplier: 1, constant: space)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal,
                                    toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -space)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal,
                                    toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -space)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal,
                                    toItem: toastContainer, attribute: .top, multiplier: 1, constant: space)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal,
                                    toItem: controller.view, attribute: .leading, multiplier: 1, constant: space/2)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal,
                                    toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -space/2)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal,
                                    toItem: controller.view, attribute: .bottom, multiplier: 1, constant: space*3*Helper.hr())
        controller.view.addConstraints([c1, c2, c3])
        
        controller.view.layoutIfNeeded()
        
        c3.constant = -space*Helper.hr()-sh
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            controller.view.layoutIfNeeded()
            toastContainer.alpha = 1.0
        }, completion: { _ in
            c3.constant = space*3*Helper.hr()
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                controller.view.layoutIfNeeded()
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
