//
//  ViewCodeProtocol.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ViewCodeProtocol {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeProtocol {
    
    func configureViews() { }
    
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
