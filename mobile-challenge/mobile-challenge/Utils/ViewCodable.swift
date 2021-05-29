//
//  ViewCodable.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

/// Protocol used to guide ViewCode
protocol ViewCodable: UIView {
    func setupViews()
    func setupConstraints()
    func setupViewHierarchy()
    func setupAdditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
