//
//  CurrencyCollectionViewCell.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 12/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var label: UILabel?
    
    func setValue(value: String){
        label?.text = value
    }
}
