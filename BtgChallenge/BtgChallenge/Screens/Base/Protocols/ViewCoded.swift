//
//  BaseView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol ViewCoded: class {
    func setupViewHierarhy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCoded {
    func setupView() {
        setupViewHierarhy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
