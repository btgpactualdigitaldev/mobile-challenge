//
//  ViewCodable.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import Foundation

protocol ViewCodable {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodable {
    
    func configureViews() {}
    
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
    
}
