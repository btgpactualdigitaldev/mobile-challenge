//
//  CurrencyViewCell.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 06/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class CurrencyViewCell: UITableViewCell {
    //MARK: Attributes
    let currencyLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let currencyNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    static let identifier = "CurrencyViewCell"
    static let height: CGFloat = 80.0
    
    //MARK: View LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Functions
    fileprivate func setupConstraints() {
        self.addSubview(currencyLabel)
        self.addSubview(currencyNameLabel)
        
        currencyLabel.topAnchor.anchor(self.topAnchor, 16)
        currencyLabel.leftAnchor.anchor(self.leftAnchor, 16)
        
        currencyNameLabel.topAnchor.anchor(currencyLabel.bottomAnchor, 4)
        currencyNameLabel.leftAnchor.anchor(currencyLabel.leftAnchor)
        currencyNameLabel.rightAnchor.anchor(self.rightAnchor, -8)
    }
    
    func setup(currency: String, name: String) {
        self.currencyLabel.text = currency
        self.currencyNameLabel.text = name
    }
}
