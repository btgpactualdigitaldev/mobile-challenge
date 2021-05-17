//
//  CurrencyTableViewCell.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 28/03/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    // MARK: - Static Attributes
    static let reuseIdentifier: String = "CurrencyCell"
    private var currency: Currency?

    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var codeLabel: UILabel!

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public Methods
    func setupCell(currency: Currency) {
        self.currency = currency
        self.nameLabel.text = self.currency?.name
        self.codeLabel.text = self.currency?.code
    }
}
