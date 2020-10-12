//
//  ViewCodable.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

protocol ViewCodable {
    func buildView()
    func setupConstraints()
    func setupAdditionalConfig()
    func render()
    func setupView()
}

extension ViewCodable {
    func setupView(){
        buildView()
        setupConstraints()
        setupAdditionalConfig()
        render()
    }
}
