//
//  BTGSearchBar.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation
import UIKit


class BTGSearchBar: UISearchBar {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }

    private func setupLayout() {
        barTintColor = AppStyle.Color.searchBarTint
        tintColor = .white
        placeholder = "Insia o código ou nome para busca"
        clipsToBounds = true
        backgroundImage = UIImage()
        isTranslucent = false
        layer.cornerRadius = 20
        searchTextField.textColor = .black
    }
}
