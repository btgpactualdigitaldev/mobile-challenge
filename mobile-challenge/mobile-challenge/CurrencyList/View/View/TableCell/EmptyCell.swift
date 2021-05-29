//
//  EmptyCell.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import UIKit

class EmptyCell: UITableViewCell {
    
    static let identifier = "EmptyCellID"
    
    var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = CurrencyListColors.currencyTitle.color
        label.text = "Suas moedas serão mostradas aqui."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpCell() {
        setUpViews()
    }

}

extension EmptyCell: ViewCodable {
    func setUpHierarchy() {
        contentView.addSubview(label)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setUpAditionalConfiguration() {
        selectionStyle = .none
        backgroundColor = AppColors.appBackground.color
    }

}
