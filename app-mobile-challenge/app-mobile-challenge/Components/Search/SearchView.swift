//
//  Search.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class SearchView: UISearchBar {

    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    
    // Private Methods

    private func setupLayout() {
        barTintColor = DesignSystem.Colors.background
        searchTextField.backgroundColor = DesignSystem.Colors.background
        tintColor = DesignSystem.Colors.secondary
        placeholder = Constants.placeholder
        layer.borderWidth = 1.5
        layer.borderColor = DesignSystem.Colors.primary?.withAlphaComponent(0.05).cgColor
        clipsToBounds = true
        backgroundImage = UIImage()
        isTranslucent = false
        layer.cornerRadius = 20
    }
}

// Constants

fileprivate extension SearchView {
    enum Constants {
        static let placeholder: String = " Pesquise por uma moeda..."
    }
}
