//
//  CurrencyListTBCell.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    
    private let cellIdentifier = "cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: cellIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        return name
    }()
    
    func setupCell(currencieName: String) {
        nameLabel.text = currencieName
    }
}

extension CurrencyListTableViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        nameLabel.anchorCenterYToSuperview()
        nameLabel.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor, leftConstant: 20, rightConstant: 20)
    }
}
