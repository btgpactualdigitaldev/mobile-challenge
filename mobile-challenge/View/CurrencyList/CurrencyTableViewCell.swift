//
//  CurrencyTableViewCell.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 27/09/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    let codeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(17)
        label.textColor = .label
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(17)
        label.textColor = .label
        return label
    }()
    
    let fromCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(12)
        label.textColor = .label
        label.text = "USD - "
        return label
    }()
    
    let toCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(12)
        label.textColor = .label
        return label
    }()
    
    let valueDollarLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(12)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CurrencyTableViewCell: ViewCodable {
    var horizontalPadding: CGFloat { 20 }
    var verticalPadding: CGFloat { 10 }

    func setupHierarchyViews() {
        addSubview(codeLabel)
        addSubview(nameLabel)
        addSubview(fromCurrencyLabel)
        addSubview(toCurrencyLabel)
        addSubview(valueDollarLabel)
    }
    
    func setupConstraints() {
        setupCodeLabelConstraints()
        setupNameLabelConstraints()
        setupFromCurrencyLabelConstraints()
        setupToCurrencyLabelConstraints()
        setupValueDollarLabelConstraints()
    }
    
    func setupCodeLabelConstraints() {
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            codeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding),
            codeLabel.heightAnchor.constraint(equalToConstant: 20),
            codeLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            nameLabel.leftAnchor.constraint(equalTo: codeLabel.rightAnchor),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -horizontalPadding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setupFromCurrencyLabelConstraints() {
        NSLayoutConstraint.activate([
            fromCurrencyLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            fromCurrencyLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding),
            fromCurrencyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding),
            fromCurrencyLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupToCurrencyLabelConstraints() {
        NSLayoutConstraint.activate([
            toCurrencyLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            toCurrencyLabel.leftAnchor.constraint(equalTo: fromCurrencyLabel.rightAnchor),
            toCurrencyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding),
            toCurrencyLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupValueDollarLabelConstraints() {
        NSLayoutConstraint.activate([
            valueDollarLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            valueDollarLabel.leftAnchor.constraint(equalTo: toCurrencyLabel.rightAnchor),
            valueDollarLabel.rightAnchor.constraint(equalTo: rightAnchor),
            valueDollarLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding),
        ])
    }
    
    func setupAdditionalConfiguration() {
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        toCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        valueDollarLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
