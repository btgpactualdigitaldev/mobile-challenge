//
//  CurrencyTableViewCell.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {

    static let identifier: String = "CurrencyCell"
    
    private lazy var currencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var currencyCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewConfiguration
extension CurrencyTableViewCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [currencyName, currencyCode])
    }
    
    func makeConstraints() {
        currencyCode
            .make(.trailing, equalTo: self, constant: -10)
            .make([.top, .bottom], equalTo: self)
            .make(.width, equalTo: 50)
        
        currencyName
            .make(.leading, equalTo: self, constant: 10)
            .make([.top, .bottom], equalTo: currencyCode)
            .make(.trailing, equalTo: currencyCode, constant: -10)
    }
}

// MARK: - View Methods
extension CurrencyTableViewCell {
    func setupCell(with model: CurrencyCellModel) {
        currencyCode.text = model.code
        currencyName.text = model.name
    }
}
