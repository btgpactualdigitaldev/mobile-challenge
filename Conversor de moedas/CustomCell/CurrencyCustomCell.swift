//
//  CurrencyCustomCell.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import Foundation
import UIKit

class CurrencyCustomCustomCell: UITableViewCell {
    @IBOutlet weak var cellCurrencyCode:UILabel!
    @IBOutlet weak var cellCurrencyDescription:UILabel!
        
    func configureCell(item: CurrencyResult) {
        cellCurrencyCode.text        = item.code
        cellCurrencyDescription.text = item.description
    }
    
}
