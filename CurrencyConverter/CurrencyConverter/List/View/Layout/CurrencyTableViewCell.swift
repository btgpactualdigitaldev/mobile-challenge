//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    // MARK: - Layout Vars
    private lazy var titleLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = Style.defaultFont
        label.textColor = Style.defaultPrimaryTextColor
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = Style.defaultFont
        label.textColor = Style.defaultSecondaryTextColor
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel]).useConstraint()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        contentView.backgroundColor = Style.veryDarkGray
        contentView.addSubview(stackView)
        stackView
            .centerY(contentView.centerYAnchor)
            .leading(anchor: contentView.leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: contentView.trailingAnchor, constant: Style.defaultTrailing)
    }
}
