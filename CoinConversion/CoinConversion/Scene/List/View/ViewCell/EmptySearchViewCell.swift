//
//  EmptySearchViewCell.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 20/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

class EmptySearchViewCell: UITableViewCell {
    
    @IBOutlet private weak var txtWithout: UILabel! {
        didSet {
            txtWithout.text = "Nenhuma moeda encontrada"
            txtWithout.textColor = .colorGrayPrimary
        }
    }
}
