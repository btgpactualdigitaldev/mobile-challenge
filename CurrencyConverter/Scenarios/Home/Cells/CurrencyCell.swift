//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 11/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Reusable
import UIKit

final class CurrencyCell: UITableViewCell, NibReusable {

    // MARK: - Outlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    // MARK: - Properties

    var model: CurrencyModel? {
        didSet {
            guard let model = model else {
                return
            }

            titleLabel.text = model.name
            descriptionLabel.text = model.nameFull
            valueLabel.text = "Cotação atual de \(String(format: "%.2f", model.quote).replacingOccurrences(of: ".", with: ",")) em relação ao dólar."
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
