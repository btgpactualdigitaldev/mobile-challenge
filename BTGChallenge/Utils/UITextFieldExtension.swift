//
//  UITextFieldExtension.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit

extension UITextField {
    static func acessoryView(completion: () -> Void) -> UIView {
        let finishButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 50, y: 0, width: 30, height: UIScreen.main.bounds.height * 0.05))
        finishButton.setTitle("OK", for: .normal)
        finishButton.addTarget(self, action: #selector(actionAccessory), for: .touchUpInside)
        finishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        finishButton.setTitleColor(.systemBlue, for: .normal)
        
        let viewAcessory = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.05))
        viewAcessory.backgroundColor = .systemFill
        viewAcessory.addSubview(finishButton)
        return viewAcessory
    }
    
    @objc func actionAccessory(completion: () -> Void) {
        completion()
    }
}
