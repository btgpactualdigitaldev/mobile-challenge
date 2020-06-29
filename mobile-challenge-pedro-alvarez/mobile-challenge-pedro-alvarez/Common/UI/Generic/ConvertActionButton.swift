//
//  ConvertAtionButton.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ConvertActionButton: UIButton {
    
    private let defaultWidth: CGFloat = 1
    private let defaultText: String = "Aplicar conversão"
    private let fontSize: CGFloat = 14
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                enableButton()
            }
            else {
                disableButton()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Could not load button")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.height / 2
        clipsToBounds = true
    }
    
    private func setup() {
        layer.borderWidth = defaultWidth
        layer.borderColor = UIColor.convertButtonLayerColor.cgColor
        disableButton()
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        setTitle(defaultText, for: .normal)
    }
    
    private func enableButton() {
        backgroundColor = .convertButtonBackgroundColor
    }
    
    private func disableButton() {
        backgroundColor = .convertionButtonDeactivactedBackground
    }
}
