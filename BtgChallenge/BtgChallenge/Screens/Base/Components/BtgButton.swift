//
//  BtgButton.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

protocol BtgButtonDelegate: class {
    func didTapButton(view: BtgButton)
}

class BtgButton: UIButton {

    // MARK: - Properties
    
    weak var delegate: BtgButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.darkBlue
        layer.cornerRadius = 30
        clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc fileprivate func handleTap() {
        delegate?.didTapButton(view: self)
    }
    
    // MARK: - Scale Animation
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !state.contains(.disabled) {
            performScaleAnimation()
        }
        super.touchesBegan(touches, with: event)
    }
    
    func performScaleAnimation() {
        layer.removeAllAnimations()
        
        let scaleDownAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleDownAnimation.fromValue = 1.0
        scaleDownAnimation.toValue = 0.95
        scaleDownAnimation.duration = 0.17
        scaleDownAnimation.isRemovedOnCompletion = true
        scaleDownAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let scaleUpAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleUpAnimation.fromValue = 0.95
        scaleUpAnimation.toValue = 1.0
        scaleUpAnimation.beginTime = scaleDownAnimation.duration
        scaleUpAnimation.duration = 0.33
        scaleUpAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleDownAnimation, scaleUpAnimation]
        animationGroup.duration = scaleDownAnimation.duration + scaleUpAnimation.duration
        
        layer.add(animationGroup, forKey: "scaleAnimation")
    }
    
}
