//
//  CurrencyListCell.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class CurrencyListCell: UITableViewCell {
    
    // MARK: - Properties
    
    let countryAbbreviationText: UILabel  = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let fullNameText: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    /// initializing cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// setting background color of the view
    func configureViews() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    /// setting hierarchy of the view
    func setupViewHierarchy() {
        self.contentView.addSubview(countryAbbreviationText)
        self.contentView.addSubview(fullNameText)
    }
    
    /// setting constrains of the view
    func setupConstraints() {
        countryAbbreviationText.translatesAutoresizingMaskIntoConstraints = false
        countryAbbreviationText.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        countryAbbreviationText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        countryAbbreviationText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        fullNameText.translatesAutoresizingMaskIntoConstraints = false
        fullNameText.topAnchor.constraint(equalTo: countryAbbreviationText.bottomAnchor, constant: 0).isActive = true
        fullNameText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        fullNameText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        fullNameText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    
    func setup(_ countryAbbreviation: String,_ fullName: String) {
        countryAbbreviationText.text = countryAbbreviation
        fullNameText.text = fullName
    }
}
