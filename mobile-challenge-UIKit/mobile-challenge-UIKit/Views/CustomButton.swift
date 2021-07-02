//
//  CustomButton.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

class CustomButton: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: DesignSystem.Animation.duration) { [weak self] in
            self?.alpha = DesignSystem.Animation.lowAlpha
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        UIView.animate(withDuration: DesignSystem.Animation.duration) { [weak self] in
            self?.alpha = DesignSystem.Animation.lowAlpha
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: DesignSystem.Animation.duration) { [weak self] in
            self?.alpha = DesignSystem.Animation.highAlpha
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: DesignSystem.Animation.duration) { [weak self] in
            self?.alpha = DesignSystem.Animation.highAlpha
        }
    }
}
