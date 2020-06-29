//
//  ErrorView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    var errorMessage: String {
        didSet {
            errorLbl.text = errorMessage
        }
    }
    
    private lazy var imageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var errorLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    init(frame: CGRect,
                  errorMessage: String) {
        self.errorMessage = errorMessage
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: ViewCodeProtocol {
    
    func buildHierarchy() {
        addSubview(imageView)
        addSubview(errorLbl)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: imageView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        errorLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: errorLbl,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: imageView,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 18).isActive = true
        NSLayoutConstraint(item: errorLbl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        errorLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        errorLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureViews() {
        isHidden = true
        backgroundColor = .black
        
        errorLbl.text = errorMessage
        errorLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        errorLbl.textAlignment = .center
        errorLbl.textColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "alerticon")
    }
}
