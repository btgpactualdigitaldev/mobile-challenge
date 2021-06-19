//
//  UIView.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import UIKit

extension UIView {
    func showSpinner() {
        DispatchQueue.main.async {
            let spinnerView = UIView.init(frame: self.bounds)
            spinnerView.backgroundColor =
                DesignSystem.Colors.background?.withAlphaComponent(0.5) ??
                UIColor.white.withAlphaComponent(0.5)
            let animation = UIActivityIndicatorView.init(style: .medium)
            animation.startAnimating()
            animation.center = spinnerView.center
            spinnerView.tag = 999
            DispatchQueue.main.async {
                spinnerView.addSubview(animation)
                self.addSubview(spinnerView)
            }
        }
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            self.viewWithTag(999)?.removeFromSuperview()
        }
    }
}

