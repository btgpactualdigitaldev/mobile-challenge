//
//  CurrencyListUITableViewCell.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyListUITableViewCell: UITableViewCell {
        
    private var currencyName: String
    private var currencyID: String
    
    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.text = currencyName
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        return label
    }()
    
    private lazy var currencyIDLabel: UILabel = {
        let label = UILabel()
        label.text = currencyID
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        return label
    }()
    
    init(currencyName: String, currencyID: String) {
        self.currencyName = currencyName
        self.currencyID = currencyID
        super.init(style: .default, reuseIdentifier: CurrencyListUITableViewCell.cellID())
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let currencyName = coder.decodeObject(forKey: "currencyName") as? String,
              let currencyID = coder.decodeObject(forKey: "currencyID") as? String else {
            return nil
        }
        self.init(currencyName: currencyName, currencyID: currencyID)
    }
    
    class func cellID() -> String {
        "CurrencyListUITableViewCell"
    }
    
    private func createConstraints() {
        currencyNameLabel.addAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 0), size: .init(width: self.frame.width * 0.5, height: 10))
        
        currencyIDLabel.addAnchor(top: nil, leading: self.leadingAnchor, trailing: nil, bottom: self.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: self.frame.width * 0.5, height: 10))
    }
}
