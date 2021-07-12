//
//  TableCurrencyCell.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 25/11/20.
//

import Foundation
import UIKit

class TableCurrencyCell: UITableViewCell {
    
    //MARK: -Variables
    
    var nameCurrency:String = ""
    var quote:Double = 0.0
    
    lazy var imageCountry : UIImageView = {
        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var currencyValue : UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    //MARK: -Required Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableCurrencyCell{
    
    func setupCell(){
        contentView.addSubview(currencyValue)
    }
}
