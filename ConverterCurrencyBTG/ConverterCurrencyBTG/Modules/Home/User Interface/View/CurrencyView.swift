//
//  CurrencyView.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class CurrencyView: UIView {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var viewModel: HomeViewModel!
    
    class func instanceFromNib() -> CurrencyView {
        return UINib(nibName: "CurrencyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CurrencyView
    }
       
    func configure(viewModel: HomeViewModel){
        self.viewModel = viewModel
        self.isUserInteractionEnabled = true
        flagImageView.image = viewModel.imageView
        titleLabel.text = viewModel.name
        subTitleLabel.text = viewModel.currency
    }
}
