//
//  BTGCurrencyCell.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import UIKit

class BTGCurrencyCell: UITableViewCell {
    
    var codeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


fileprivate extension BTGCurrencyCell {
    func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    func addViews() {
        self.contentView.addSubViews(views: [
            codeLabel,
            nameLabel
        ])
    }
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            codeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
}

extension BTGCurrencyCell {
    func update(currency: Currency) {
        codeLabel.text = currency.code
        nameLabel.text = currency.name
    }
}
