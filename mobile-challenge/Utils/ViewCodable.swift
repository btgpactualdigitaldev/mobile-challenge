//
//  ViewCodable.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

protocol ViewCodable {
    func setupViews()
    func setupHierarchyViews()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupHierarchyViews()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
