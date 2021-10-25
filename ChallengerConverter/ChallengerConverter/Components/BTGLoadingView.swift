//
//  BTGLoadingView.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import Foundation
import UIKit


class BTGLoadingView: UIView {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        let animation = UIActivityIndicatorView.init(style: .large)
        animation.startAnimating()
        animation.center = self.center
        animation.color = AppStyle.Color.spinnerColor
        self.addSubview(animation)
    }
}


extension BTGLoadingView {
    
    static func show(to: UIView) {
        print(UIScreen.main.bounds)
        let spinnerView = BTGLoadingView(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = AppStyle.Color.spinnerBackground
        to.addSubview(spinnerView)
    }
    
    static func hide(superView: UIView) {
        for view in superView.subviews.reversed() {
            if(view.isKind(of: BTGLoadingView.self)) {
                view.removeFromSuperview()
            }
        }
    }
}
