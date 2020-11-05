//
//  CurrenciesViewCell.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation
import UIKit

class CurrenciesViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.text = "name"
        
        return label
    }()
    
    lazy var codeLabel: UILabel = {
        var label = UILabel()
        
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = "code"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrenciesViewCell: ViewCodable{
    func setupViewHierarchy() {
        self.addSubview(nameLabel)
        self.addSubview(codeLabel)
    }
    
    func setupConstraints() {
        // Name label Anchors
        self.nameLabel.anchor(left: self.leftAnchor, paddingLeft: self.frame.width * 0.05)
        self.nameLabel.anchor(width: self.frame.width * 0.75)
        self.nameLabel.centerY(in: self)
        
        // Code label Anchors
        self.codeLabel.anchor(right: self.rightAnchor, paddingRight: self.frame.width * 0.02)
        self.codeLabel.anchor(width: self.frame.width * 0.15)
        self.codeLabel.centerY(in: self)
    }
}
