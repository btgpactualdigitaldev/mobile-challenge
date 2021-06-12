//
//  UIButton+.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    var corner: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.frame = bounds
        shapeLayer.fillColor = nil
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath
        self.layer.cornerRadius = 4
        layer.addSublayer(shapeLayer)
    }
}
