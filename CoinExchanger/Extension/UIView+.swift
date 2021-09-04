//
//  UIView+Extensions.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 08/12/20.
//

import UIKit

extension UIView {
    // MARK: animateBorderColor
    /// Change border color gradually
    func animateBorderColor(_ color: UIColor, duration: Double) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = color.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = color.cgColor
      }
    
    // MARK: applyShadows
    /// Create and apply especified or default shadow
    func applyShadows(shadowColor: CGColor = UIColor.black.cgColor,
                      shadowOffset: CGSize = CGSize(width: 0, height: 2),
                      shadowRadius: CGFloat = 2.0,
                      shadowOpacity: Float = 0.2) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
    }
    
    // MARK: roundCorners
    /// Creates a belzierPath w round corners especified
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // MARK: roundCornersAndTip
    /// Creates a belzierPath w round corners and tip
    func roundCornersAndTip(corners: UIRectCorner, radius: CGFloat, pointUp: Bool) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let trianglePath = (pointUp) ? createTipPathUp(of: radius) : createTipPathDown(of: radius)
        path.append(trianglePath)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = self.backgroundColor?.cgColor
        self.backgroundColor = .clear
        self.layer.insertSublayer(shape, at: 0)
    }
    
    // MARK: createTipPathUp
    /// Creates a belzierPath poited up
    func createTipPathUp(of tipSize: CGFloat) -> UIBezierPath {
        let tooltipRect = CGRect(x: bounds.minX, y: bounds.minY-tipSize, width: bounds.width, height: tipSize)
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: tooltipRect.midX, y: tooltipRect.minY))
        trianglePath.addLine(to: CGPoint(x: tooltipRect.maxX, y: tooltipRect.maxY))
        trianglePath.addLine(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.maxY))
        trianglePath.addLine(to: CGPoint(x: tooltipRect.midX, y: tooltipRect.minY))
        trianglePath.close()
        return trianglePath
    }
    
    // MARK: createTipPathDown
    /// Creates a belzierPath poited down
    func createTipPathDown(of tipSize: CGFloat) -> UIBezierPath {
        let tooltipRect = CGRect(x: bounds.minX, y: bounds.maxY, width: bounds.width, height: tipSize)
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.minY))
        trianglePath.addLine(to: CGPoint(x: tooltipRect.maxX, y: tooltipRect.minY))
        trianglePath.addLine(to: CGPoint(x: tooltipRect.midX, y: tooltipRect.maxY))
        trianglePath.addLine(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.minY))
        trianglePath.close()
        return trianglePath
    }
}

extension UIView {
    // MARK: createTipPathDown
    /// Creates a belzierPath poited down
    public func checkTAMIC() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// MARK: top
extension UIView {
    /// Link current view TOP anchor to anchor
    @discardableResult
    public func top(equalTo: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    /// Link current view TOP anchor to view TOP anchor
    @discardableResult
    public func top(equalTo view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? top(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            : top(equalTo: view.topAnchor, constant: constant)
    }
    
    /// Link current view TOP anchor to anchor or less
    @discardableResult
    public func top(lessThan: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.topAnchor.constraint(lessThanOrEqualTo: lessThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view TOP anchor to view TOP anchor or less
    @discardableResult
    public func top(lessThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? top(lessThan: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            : top(lessThan: view.topAnchor, constant: constant)
    }
    
    /// Link current view TOP anchor to view TOP anchor or more
    @discardableResult
    public func top(greaterThan: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.topAnchor.constraint(greaterThanOrEqualTo: greaterThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view TOP anchor to view TOP anchor or less
    @discardableResult
    public func top(greaterThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? top(greaterThan: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            : top(greaterThan: view.topAnchor, constant: constant)
    }
    
    // MARK: topToBottom
    /// Link current view TOP anchor to view BOTTOM anchor
    @discardableResult
    public func topToBottom(of view: UIView, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
        return self
    }
    
    /// Link current view TOP anchor to view BOTTOM anchor
    @discardableResult
    public func topToBottom(lessThan view: UIView, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.topAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: constant).isActive = true
        return self
    }
    
    /// Link current view TOP anchor to anchor or more
    @discardableResult
    public func topToBottom(greaterThan view: UIView, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.topAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: constant).isActive = true
        return self
    }
}

// MARK: left
extension UIView {
    /// Link current view LEFT anchor to anchor
    @discardableResult
    public func left(equalTo: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.leftAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    /// Link current view LEFT anchor to view LEFT anchor
    @discardableResult
    public func left(equalTo view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? left(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: constant)
            : left(equalTo: view.leftAnchor, constant: constant)
    }
    
    /// Link current view LEFT anchor to anchor or less
    @discardableResult
    public func left(lessThan: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.leftAnchor.constraint(lessThanOrEqualTo: lessThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view LEFT anchor to view LEFT anchor or less
    @discardableResult
    public func left(lessThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? left(lessThan: view.safeAreaLayoutGuide.leftAnchor, constant: constant)
            : left(lessThan: view.leftAnchor, constant: constant)
    }
    
    /// Link current view LEFT anchor to anchor or more
    @discardableResult
    public func left(greaterThan: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.leftAnchor.constraint(greaterThanOrEqualTo: greaterThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view LEFT anchor to view LEFT anchor or more
    @discardableResult
    public func left(greaterThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? left(greaterThan: view.safeAreaLayoutGuide.leftAnchor, constant: constant)
            : left(greaterThan: view.leftAnchor, constant: constant)
    }
}

// MARK: right
extension UIView {
    /// Link current view RIGHT anchor to anchor
    @discardableResult
    public func right(equalTo: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.rightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    /// Link current view RIGHT anchor to view RIGHT anchor
    @discardableResult
    public func right(equalTo view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? right(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: constant)
            : right(equalTo: view.rightAnchor, constant: constant)
    }
    
    /// Link current view RIGHT anchor to anchor or less
    @discardableResult
    public func right(lessThan: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.rightAnchor.constraint(lessThanOrEqualTo: lessThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view RIGHT anchor to view RIGHT anchor or less
    @discardableResult
    public func right(lessThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? right(lessThan: view.safeAreaLayoutGuide.rightAnchor, constant: constant)
            : right(lessThan: view.rightAnchor, constant: constant)
    }
    
    /// Link current view RIGHT anchor to anchor or more
    @discardableResult
    public func right(greaterThan: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.rightAnchor.constraint(greaterThanOrEqualTo: greaterThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view RIGHT anchor to view RIGHT anchor or more
    @discardableResult
    public func right(greaterThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? right(greaterThan: view.safeAreaLayoutGuide.rightAnchor, constant: constant)
            : right(greaterThan: view.rightAnchor, constant: constant)
    }
}

// MARK: bottom
extension UIView {
    /// Link current view BOTTOM anchor to anchor
    @discardableResult
    public func bottom(equalTo: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    /// Link current view BOTTOM anchor to view BOTTOM anchor
    @discardableResult
    public func bottom(equalTo view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? bottom(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
            : bottom(equalTo: view.bottomAnchor, constant: constant)
    }
    
    /// Link current view BOTTOM anchor to anchor or less
    @discardableResult
    public func bottom(lessThan: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.bottomAnchor.constraint(lessThanOrEqualTo: lessThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view BOTTOM anchor to view BOTTOM anchor or less
    @discardableResult
    public func bottom(lessThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? bottom(lessThan: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
            : bottom(lessThan: view.bottomAnchor, constant: constant)
    }
    
    /// Link current view BOTTOM anchor to anchor or more
    @discardableResult
    public func bottom(greaterThan: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.bottomAnchor.constraint(greaterThanOrEqualTo: greaterThan, constant: constant).isActive = true
        return self
    }
    
    /// Link current view BOTTOM anchor to view BOTTOM anchor or more
    @discardableResult
    public func bottom(greaterThan view: UIView, constant: CGFloat = 0, safeArea: Bool = false) -> Self {
        return safeArea
            ? bottom(greaterThan: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
            : bottom(greaterThan: view.bottomAnchor, constant: constant)
    }
}

//MARK: width
extension UIView {
    /// Link current view WIDTH anchor to CONSTANT
    @discardableResult
    public func width(constant: CGFloat) -> Self {
        checkTAMIC()
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    /// Link current view WIDTH anchor to view WIDTH anchor
    @discardableResult
    public func width(equalTo view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.widthAnchor.constraint(equalTo: view.widthAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        return self
    }
    
    /// Link current view WIDTH anchor to view WIDTH anchor or less
    @discardableResult
    public func width(lessThan view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        return self
    }
    
    /// Link current view WIDTH anchor to view WIDTH anchor or more
    @discardableResult
    public func width(greaterThan view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        return self
    }
}

// MARK: height
extension UIView {
    /// Link current view HEIGHT anchor to CONSTANT
    @discardableResult
    public func height(constant: CGFloat) -> Self {
        checkTAMIC()
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    /// Link current view HEIGHT anchor to view HEIGHT anchor
    @discardableResult
    public func height(equalTo view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.heightAnchor.constraint(equalTo: view.heightAnchor,
                                     multiplier: multiplier,
                                     constant: constant).isActive = true
        return self
    }
    
    /// Link current view HEIGHT anchor to view HEIGHT anchor or less
    @discardableResult
    public func height(lessThan view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        return self
    }
    
    /// Link current view HEIGHT anchor to view HEIGHT anchor or more
    @discardableResult
    public func height(greaterThan view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        return self
    }
}

extension UIView {
    // MARK: centerX
    /// Link current view MIDX anchor to view MIDX anchor
    @discardableResult
    public func centerX(equalTo: UIView, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.centerXAnchor.constraint(equalTo: equalTo.centerXAnchor, constant: constant).isActive = true
        return self
    }
    
    // MARK: centerY
    /// Link current view MIDY anchor to view MIDY anchor
    @discardableResult
    public func centerY(equalTo: UIView, constant: CGFloat = 0) -> Self {
        checkTAMIC()
        self.centerYAnchor.constraint(equalTo: equalTo.centerYAnchor, constant: constant).isActive = true
        return self
    }
    
    // MARK: center
    /// Link current view CENTER anchor to view CENTER anchor
    @discardableResult
    public func center(in view:UIView) -> Self {
        checkTAMIC()
        self.centerY(equalTo: view)
        self.centerX(equalTo: view)
        return self
    }
    
    // MARK: size
    /// Link current view HEIGHT & WIDTH anchor to CONSTANT
    @discardableResult
    public func size(constant: CGFloat) -> Self {
        checkTAMIC()
        self.height(constant: constant)
        self.width(constant: constant)
        return self
    }
    
    /// Link current view HEIGHT & WIDTH anchor to view HEIGHT & WIDTH
    @discardableResult
    public func size(equalTo view: UIView, multiplier: CGFloat = 1) -> Self {
        checkTAMIC()
        self.height(equalTo: view, multiplier: multiplier)
        self.width(equalTo: view, multiplier: multiplier)
        return self
    }
}

extension UIView {
    // MARK: fillTo
    /// Link current view LEFT & RIGHT & TOP & BOTTOM anchor to view LEFT & RIGHT & TOP & BOTTOM anchor
    @discardableResult
    public func fill(to view: UIView, constant: CGFloat = 0, safeArea: Bool = true) -> Self {
        top(equalTo: view, constant: constant, safeArea: safeArea)
            .bottom(equalTo:view, constant: -constant, safeArea: safeArea)
            .left(equalTo: view, constant: constant, safeArea: safeArea)
            .right(equalTo: view, constant: -constant, safeArea: safeArea)

        return self
    }
    
    // MARK: fillHorizontal
    /// Link current view LEFT & RIGHT anchor to view LEFT & RIGHT anchor
    @discardableResult
    public func fillHorizontal(to view: UIView, constant: CGFloat = 0) -> Self {
        left(equalTo: view.leftAnchor, constant: constant)
            .right(equalTo: view.rightAnchor, constant: -constant)
        return self
    }
    
    // MARK: fillVertical
    /// Link current view TOP & BOTTOM anchor to view TOP & BOTTOM anchor
    @discardableResult
    public func fillVertical(to view: UIView, constant: CGFloat = 0) -> Self {
        top(equalTo: view.topAnchor, constant: constant)
            .bottom(equalTo: view.bottomAnchor, constant: -constant)
        return self
    }
    
    // MARK: ratio
    /// Link current view TOP & BOTTOM anchor to view TOP & BOTTOM anchor
    @discardableResult
    public func aspectRatio(_ multiplier: CGFloat = 1) -> Self {
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
}
