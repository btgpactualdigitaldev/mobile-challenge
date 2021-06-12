//
//  UIView+Shimmer.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

let kAlphaColor: CGFloat = 0.3
let kAlphaDarkColor: CGFloat = 0.8
let kStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
let kEndPoint: CGPoint = CGPoint(x: 1, y: 0.5)
let kShimmerDuration = 0.9
let kKeyPathAnimation = "locations"
let kAnimationShimmer = "shimmer"

internal extension UIView {
    // MARK: - shimmer
    func startShimmer() {
        let light = UIColor.white.withAlphaComponent(kAlphaColor).cgColor
        let dark = UIColor.black.withAlphaComponent(kAlphaDarkColor).cgColor
        let gradient = CAGradientLayer()
        gradient.colors = [dark,light,dark]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width,
                                height: self.bounds.size.height)
        gradient.startPoint = kStartPoint
        gradient.endPoint = kEndPoint
        gradient.locations = [0.3, 0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
}
