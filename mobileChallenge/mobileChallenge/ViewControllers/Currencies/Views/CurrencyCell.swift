//
//  CurrencyCell.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.textColor = .black
        
        return titleLabel
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        buildHierarchy()
        buildConstraints()
    }
    
    func buildHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 48.0),
            
            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupCell(currency: Currency) {
        titleLabel.text = currency.code
        subTitleLabel.text = currency.name
    }
}

// MARK: - Reusable Extension
extension CurrencyCell: Reusable {
    static var nib: UINib? { return nil }
}
