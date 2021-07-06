//
//  CurrencyListTableViewCell.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell, Identifiable {
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    private let currencyShortNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.backgroundColor = .clear
    }
    
    func setupCurrencyWithName(_ name: String, withShortName shortName: String){
        self.currencyNameLabel.text = name
        self.currencyShortNameLabel.text = shortName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Codable Protocol

extension CurrencyListTableViewCell: ViewCodable {
    
    func setupViewHierarchy() {
        addSubview(currencyNameLabel)
        addSubview(currencyShortNameLabel)
    }
    
    func setupConstraints() {
        setupCurrencyNameLabelConstraints()
        setupcurrencyShortNameLabelConstraints()
    }
    
    private func setupCurrencyNameLabelConstraints(){
        currencyNameLabel.anchor(width: ScreenSize.width * 0.8)
        currencyNameLabel.centerY(in: self)
        currencyNameLabel.anchor(left: leftAnchor, paddingLeft: ScreenSize.width * 0.06)
    }
    
    private func setupcurrencyShortNameLabelConstraints(){
        currencyShortNameLabel.centerY(in: self)
        currencyShortNameLabel.anchor(left: currencyNameLabel.rightAnchor)
    }
    
}
