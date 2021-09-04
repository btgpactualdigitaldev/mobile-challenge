//
//  VisualInputSearch.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 18/08/21.
//

import UIKit

class VisualInputSearch: VisualInput {
    var rotateEnabled = true
    var paddingEnabled = true
    
    var button: UIButton = {
        var ico: UIImage?
        
        if #available(iOS 13.0, *) {
            ico = UIImage(systemName: "magnifyingglass")
        }
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.topAnchor.constraint(equalTo: button.topAnchor,
                                               constant: 12).isActive = true
        button.imageView?.bottomAnchor.constraint(equalTo: button.bottomAnchor,
                                                  constant: -12).isActive = true
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor,
                                                constant: 12).isActive = true
        button.imageView?.rightAnchor.constraint(equalTo: button.rightAnchor,
                                                 constant: -12).isActive = true
        button.setImage(ico, for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .gray
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
                           width: bounds.maxX-64, height: bounds.maxY-8)
        return paddingEnabled ? frame : super.editingRect(forBounds: bounds)
    }

}

private extension VisualInputSearch {
    // MARK: Setup
    func setup() {
        rightViewMode = .always
        
        padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 64)
        
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 48).isActive = true
        v.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        v.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        //button.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        //button.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        rightView = v
        
        button.addTarget(self, action: #selector(didTouch(_:)), for: .touchUpInside)
    }
    
    @objc
    func didTouch(_ view: UIView) {
        self.resignFirstResponder()
    }
}
