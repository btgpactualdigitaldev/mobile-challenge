//
//  UIButtonExtension.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 25/04/21.
//

import UIKit

extension UIButton {
    func rotateAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 0.7
        rotationAnimation.repeatCount = .infinity
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    func removeAllAnimations() {
        DispatchQueue.main.async {
            self.layer.removeAllAnimations()
        }
    }
    
}
