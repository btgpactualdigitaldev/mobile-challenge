//
//  LoadingView.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 01/11/20.
//

import UIKit

class CircleLoadingView: UIView {
    
    private var cirlceLayer: CAShapeLayer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required init(radius: CGFloat) {
        super.init(frame: .zero)
        setupShapeLayer(radius)
        NotificationCenter.default.addObserver(self, selector: #selector(setupAnimation), name: NSNotification.Name(rawValue: "appDidBecomeActive"), object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAnimation()
    }
    
    private func setupShapeLayer(_ radius: CGFloat) {
        let path = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        cirlceLayer = CAShapeLayer()
        cirlceLayer.path = path.cgPath
        cirlceLayer.fillColor = UIColor.clear.cgColor
        cirlceLayer.strokeColor = UIColor.white.cgColor
        cirlceLayer.lineWidth = 2.5
        cirlceLayer.lineJoin = .round
        cirlceLayer.lineCap =  .round
        cirlceLayer.strokeEnd = 1
        cirlceLayer.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        cirlceLayer.zPosition = CGFloat.leastNormalMagnitude
        layer.addSublayer(cirlceLayer)
    }
    
    @objc func setupAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeColor")
        animation.fromValue = UIColor.white.cgColor
        animation.toValue = UIColor.darkGray.cgColor
        animation.duration = 0.75
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        cirlceLayer.add(animation, forKey: "strokeColor")
    }
}

class LoadingView: UIView {
    
    private lazy var circleLoadingView: CircleLoadingView = {
        let circleLoadingView = CircleLoadingView(radius: 25).useConstraint()
        return circleLoadingView
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        backgroundColor = .black
        addSubview(circleLoadingView)
        circleLoadingView
            .height(constant: 50)
            .width(constant: 50)
            .centerX(centerXAnchor)
            .centerY(centerYAnchor)
    }
}
