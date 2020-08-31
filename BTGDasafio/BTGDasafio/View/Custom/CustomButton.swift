//
//  CustomButton.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 30/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//
import UIKit

class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        setDefaultValues()
    }
    
    func setDefaultValues() {
        backgroundColor = UIColor.black
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel?.textColor = UIColor.white
    }
    
    @IBInspectable var rounded: Bool = true {
        didSet { updateCornerRadius() }
    }
    
    func updateCornerRadius() {
        let cornedValue = (frame.size.height - 5) / 2
        layer.cornerRadius = rounded ? cornedValue : 0
    }
}
