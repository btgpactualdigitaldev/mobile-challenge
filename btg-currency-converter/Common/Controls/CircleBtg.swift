//
//  Circle.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 19/11/20.
//

import UIKit

protocol CircleBtgDelegate : class {
    func didStopAnimation()
}

@IBDesignable
class CircleBtg: UIView {

    var circleLayer: CAShapeLayer!
    weak var delegate : CircleBtgDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)

        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2.0;
        circleLayer.strokeEnd = 0.0
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        circleLayer.strokeEnd = 1.0
        circleLayer.add(animation, forKey: "animateCircle")
    }
}

extension CircleBtg: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if(flag){
            sleep(3)
            delegate?.didStopAnimation()
        }
    }
}
