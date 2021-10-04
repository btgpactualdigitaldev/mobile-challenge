//
//  ViewConfiguration.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

protocol ViewConfiguration: AnyObject {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
