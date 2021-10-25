//
//  UIViewExtension.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation
import UIKit


extension UIView {
    func addSubViews(views: [UIView], translatesAutoresizingMaskIntoConstraints: Bool = false) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            self.addSubview(view)
        }
    }
    
    func showSpinner() {
        BTGLoadingView.show(to: self)
    }
    
    func hideSpinner() {
        BTGLoadingView.hide(superView: self)
    }
}
