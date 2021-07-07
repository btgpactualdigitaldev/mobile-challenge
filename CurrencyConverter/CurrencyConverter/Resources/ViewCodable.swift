//
//  ViewCodable.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import Foundation

protocol ViewCodable {
    func setupViews()
    func setupHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
}
