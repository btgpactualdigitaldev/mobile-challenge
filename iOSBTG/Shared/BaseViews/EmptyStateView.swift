//
//  EmptyStateView.swift
//  iOSBTG
//
//  Created by Filipe Merli on 12/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

final class EmptyStateView: UIView {
    
    // MARK:  Properties
        
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        label.text = "Offline"
        return label
    }()
    
    override func didMoveToSuperview() {
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        self.addSubview(mainLabel)
        mainLabel.backgroundColor = .groupTableViewBackground
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
}
