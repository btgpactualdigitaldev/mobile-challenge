//
//  LoadingView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import UIKit

class LoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
        
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUpViews()
    }
    
    convenience init(frame: CGRect = .zero,
                     backgroundColor: UIColor? = .clear,
                     style: UIActivityIndicatorView.Style = .medium) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.activityIndicator.style = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View lifecycle
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        activityIndicator.startAnimating()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}

extension LoadingView: ViewCodable {
    func setUpHierarchy() {
        addSubview(activityIndicator)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
