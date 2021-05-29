//
//  CurrencyTableViewCell.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrencyTableViewCellID"
    
    var currency: CurrencyModel? {
        didSet{
            currencyLabel.text = "\(currency?.code ?? "") | \(currency?.name ?? "")"
        }
    }
    
    var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension CurrencyTableViewCell: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            currencyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(currencyLabel)
    }
}
