//
//  CurrencyCellView.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit
import SnapKit

class CurrencyCellView: UITableViewCell {
    
    var nameCurrency: UILabel
    var name: String?
    var acronym: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.nameCurrency = UILabel()
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyCellView: ViewCodable {
    
    func buildHierarchy() {
        addSubview(nameCurrency)
    }
    
    func setupConstraints() {
        nameCurrency.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(0.6)
            make.left.equalTo(self.contentView.snp_leftMargin)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func configureViews() {
        nameCurrency.font = UIFont.preferredFont(forTextStyle: .body)
        nameCurrency.textColor = .black
        nameCurrency.textAlignment = .left
    }
    
}
