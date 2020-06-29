//
//  CurrencyListTableViewCell.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    private lazy var currencyLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private(set) var currencyAttrString: NSAttributedString?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(currencyAttrString: NSAttributedString) {
        self.currencyAttrString = currencyAttrString
        applyViewCode()
    }
}

extension CurrencyListTableViewCell: ViewCodeProtocol {
    
    func buildHierarchy() {
        containerView.addSubview(currencyLbl)
        addSubview(containerView)
    }
    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: containerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: containerView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.8).isActive = true
        
        currencyLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: currencyLbl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: currencyLbl,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        currencyLbl.heightAnchor.constraint(equalToConstant: 48).isActive = true
        currencyLbl.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .white
        containerView.layer.cornerRadius = 4
        containerView.layer.borderColor = UIColor.currencyTableViewCellLayerColor.cgColor
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = UIColor.currencyTableViewCellBackgrouncColor
        currencyLbl.textColor = UIColor.currencyLblColor
        backgroundColor = UIColor.currencyTableViewCellBackgrouncColor
        currencyLbl.attributedText = currencyAttrString
        currencyLbl.textAlignment = .center
    }
}
