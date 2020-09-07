//
//  EmptyCurrencyCell.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 07/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class EmptyCurrencyViewCell: UITableViewCell {
    //MARK: Attributes
    let currencyLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Não encontramos nenhum resultado :("
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.adjustsFontSizeToFitWidth = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    static let identifier = "EmptyCurrencyViewCell"
    
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
        
        currencyLabel.centerYAnchor.anchor(self.centerYAnchor)
        currencyLabel.leftAnchor.anchor(self.leftAnchor, 8)
        currencyLabel.rightAnchor.anchor(self.rightAnchor, -8)
    }
}
