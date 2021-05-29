//
//  CurrencyCell.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyCell: UITableViewCell {
    static let identifier = "CurrencyCellID"
    
    var code: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = CurrencyListColors.code.color
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var name: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = CurrencyListColors.name.color
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var quotation: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = CurrencyListColors.quotation.color
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUp(){
        setUpViews()
    }
}

extension CurrencyCell: ViewCodable {
    func setUpHierarchy() {
        addSubview(code)
        addSubview(name)
        addSubview(quotation)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            code.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            code.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            name.topAnchor.constraint(equalTo: code.topAnchor),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            name.leadingAnchor.constraint(equalTo: code.trailingAnchor, constant: 5),
            
            quotation.topAnchor.constraint(equalTo: code.bottomAnchor, constant: 5),
            quotation.leadingAnchor.constraint(equalTo: code.leadingAnchor)
        ])
    }
    
    func setUpAditionalConfiguration() {
        backgroundColor = CurrencyListColors.cellBackground.color
    }
    
}
