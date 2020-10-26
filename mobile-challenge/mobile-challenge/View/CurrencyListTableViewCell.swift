//
//  CurrencyListTableViewCell.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 24/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    // MARK: - Attributes
    public static let cellIdentifier = "CurrencyListTableViewCell"
    public static let cellHeight: CGFloat = 40
    
    // MARK: - Layout Attributes
    fileprivate let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    fileprivate let currencyTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    fileprivate let currencySymbol: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .right
        lbl.textColor = UIColor.black.withAlphaComponent(0.9)
        lbl.setContentCompressionResistancePriority(.required, for: .horizontal)
        return lbl
    }()
    
    // MARK: - Functions
    public func setup(title: String, symbol: String) {
        currencyTitle.text = title
        currencySymbol.text = symbol
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        self.addSubview(stackView)
        stackView.anchor(
            top: (self.topAnchor, 8),
            left: (self.leftAnchor, 0),
            right: (self.rightAnchor, 0),
            bottom: (self.bottomAnchor, 8)
        )
        stackView.addArrangedSubview(currencyTitle)
        stackView.addArrangedSubview(currencySymbol)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

}
