//
//  VisualInputPicker.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 07/07/21.
//

import UIKit

class VisualInputPicker: VisualInput {
    var rotateEnabled = true
    var paddingEnabled = true
    
    var imageView: UIImageView = {
        var ico: UIImage?
        
        if #available(iOS 13.0, *) {
            ico = UIImage(systemName: "chevron.down")
        }
        
        let imageView = UIImageView(image: ico)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
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
                           width: bounds.maxX-56, height: bounds.maxY-8)
        return paddingEnabled ? frame : super.editingRect(forBounds: bounds)
    }

}

private extension VisualInputPicker {
    func setup() {
        self.autocorrectionType = .no
        self.inputEnabled = false
        self.rightViewMode = .always        
        
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant: 10).isActive = true
        v.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        v.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        rightView = v
        
        tintColor = .clear
    }
}

extension VisualInputPicker {
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        if self.rotateEnabled {
            UIView.animate(withDuration: Constants.animationDelay, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            })
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if self.rotateEnabled {
            UIView.animate(withDuration: Constants.animationDelay, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }

        return false
    }
}
