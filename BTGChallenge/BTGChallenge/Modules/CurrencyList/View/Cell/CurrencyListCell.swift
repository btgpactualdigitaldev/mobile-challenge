//
//  CurrencyListCell.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 11/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit


class CurrencyListCell: UITableViewCell {
    
    @IBOutlet weak var currencyCodeLbl: UILabel!
    @IBOutlet weak var currencyNameLbl: UILabel!
    
   
    
    func setLabels(data: CurrencyListViewData) {
        self.currencyCodeLbl.text = data.currencyCode
        self.currencyNameLbl.text = data.currencyName
    }
    
    func startLoading() {
        ShimmerHelper.startLoadingSkeleton(with: currencyCodeLbl)
        ShimmerHelper.startLoadingSkeleton(with: currencyNameLbl)
    }
    
}
