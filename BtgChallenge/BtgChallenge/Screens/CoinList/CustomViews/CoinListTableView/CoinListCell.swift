//
//  CoinListCell.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 14/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class CoinListCell: UITableViewCell {

    // MARK: - Constants
    
    static let labelHeight: CGFloat = 20
    static let labelMargin: CGFloat = 20
    static let labelSpacing: CGFloat = 8
    
    // MARK: - Properties
    
    lazy var shortCoinNameLabel: BtgLabelMedium = {
        return BtgLabelMedium()
    }()
    
    lazy var fullCoinNameLabel: BtgLabelMedium = {
        return BtgLabelMedium()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(viewModel: CoinListCellViewModel) {
        shortCoinNameLabel.text = viewModel.shortCoinName
        fullCoinNameLabel.text = viewModel.fullCoinName
    }

}

extension CoinListCell: ViewCoded {
    func setupViewHierarhy() {
        addSubview(shortCoinNameLabel)
        addSubview(fullCoinNameLabel)
    }
    
    func setupConstraints() {
        shortCoinNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(CoinListCell.labelHeight)
            
            make.centerY.equalToSuperview()
            
            make.top.equalToSuperview().inset(CoinListCell.labelMargin)
            make.bottom.equalToSuperview().inset(CoinListCell.labelMargin)
            make.leading.equalToSuperview().inset(CoinListCell.labelMargin)
        }
        
        fullCoinNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(CoinListCell.labelHeight)
            
            make.centerY.equalTo(shortCoinNameLabel.snp.centerY)
            
            make.leading
                .greaterThanOrEqualTo(shortCoinNameLabel.snp.trailing)
                .inset(CoinListCell.labelSpacing)
            
            make.trailing.equalToSuperview().inset(CoinListCell.labelMargin)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
