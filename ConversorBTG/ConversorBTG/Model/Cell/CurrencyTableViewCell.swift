//
//  CurrencyTableViewCell.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

///Classe que descreve uma célula da tableview que exibirá as moedas.
class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyId: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
}
