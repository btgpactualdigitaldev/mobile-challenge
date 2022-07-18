//
//  ViewCode.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func additionalConfigurations()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalConfigurations()
    }
    
    func additionalConfigurations() { }
}
