//
//  VisualInputSecure.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 16/06/21.
//

import UIKit

class VisualInputSecure: VisualInput {
    var button: UIButton = {
        var ico: UIImage?
        
        if #available(iOS 13.0, *) {
            ico = UIImage(systemName: "eye")
        }
        
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(ico, for: .normal)
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let frame = CGRect(x: bounds.minX+16, y: bounds.minY+4,
                           width: bounds.maxX-44, height: bounds.maxY-8)
        return frame
    }
}

private extension VisualInputSecure {
    func setup() {
        self.rightViewMode = .always
        self.isSecureTextEntry = true
        
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant: 44).isActive = true
        v.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        v.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        rightView = v
        
        button.addTarget(self,
                       action: #selector(didTapButton),
                       for: .touchUpInside)
        self.bringSubviewToFront(button)
    }
    
    @objc
    func didTapButton() {
        var ico: UIImage?
        
        isSecureTextEntry = !isSecureTextEntry
        
        if #available(iOS 13.0, *) {
            ico = isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        }
        
        UIView.transition(with: button, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.button.setImage(ico, for: .normal)
        }, completion: nil)
    }
}
