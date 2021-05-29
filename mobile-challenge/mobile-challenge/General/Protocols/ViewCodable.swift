//
//  ViewCodableProtocol.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

protocol ViewCodable {
    func setUpViews()
    func setUpHierarchy()
    func setUpConstraints()
    func setUpAditionalConfiguration()
}

extension ViewCodable {
    func setUpViews() {
        setUpHierarchy()
        setUpConstraints()
        setUpAditionalConfiguration()
    }
    
    func setUpAditionalConfiguration() { }
}
