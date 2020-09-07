//
//  CurrencyButton.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 06/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class CurrencyButton: UIButton {
    //MARK: View LifeCycle
    required init(title: String, height: CGFloat = 56) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: height / 3, weight: .semibold)
        self.layer.cornerRadius = height / 4
        self.clipsToBounds = true
        self.heightAnchor.anchor(height)
        self.translatesAutoresizingMaskIntoConstraints = false
        enable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    func disable() {
        self.tintColor = .black
        self.backgroundColor = .lightGray
        self.isUserInteractionEnabled = false
    }
    
    func enable() {
        self.tintColor = .white
        self.backgroundColor = .black
        self.isUserInteractionEnabled = true
    }
}
