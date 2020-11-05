//
//  ViewCodable.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import Foundation

protocol ViewCodable {
    func setupViews()
    func setupViewHierarchy()
    func setupConstraints()
}

extension ViewCodable {
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
    }
}
