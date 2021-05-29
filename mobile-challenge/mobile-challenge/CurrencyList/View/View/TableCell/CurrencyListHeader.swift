//
//  CurrencyListHeader.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import UIKit

class CurrencyListHeader: UITableViewHeaderFooterView {
    
    static let identifier = "CurrencyListHeaderID"
    
    var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = CurrencyListColors.code.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension CurrencyListHeader: ViewCodable {
    func setUpHierarchy() {
        addSubview(label)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    func setUpAditionalConfiguration() {
        tintColor = CurrencyListColors.sectionBackground.color
    }
}
