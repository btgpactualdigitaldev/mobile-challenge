//
//  ViewCodable.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import Foundation

protocol ViewCodable: class {
    /// SetUp any needed configurations
    func setUp()

    /// Set constraints for all views
    func setConstraints()

    /// Updates UI given events
    func updateUI()
}
