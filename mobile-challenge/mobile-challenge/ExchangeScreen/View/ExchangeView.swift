//
//  ExchangeView.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

class ExchangeView: UIStackView {
    
    let fromStackView = CurrencyStackView()
    let toStackView = CurrencyStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        distribution = .fill
        spacing = 18
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ExchangeView: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            fromStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fromStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fromStackView.topAnchor.constraint(equalTo: topAnchor),
            
            toStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            toStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            toStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupViewHierarchy() {
        addArrangedSubview(fromStackView)
        addArrangedSubview(toStackView)
    }
}
