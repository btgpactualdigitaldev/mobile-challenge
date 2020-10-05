//
//  CurrencyCell.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import UIKit

final class CurrencyCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setUpContentView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpContentView() {
        contentView.backgroundColor = .systemBackground
        textLabel?.font = .preferredFont(forTextStyle: .headline)
        tintColor = .systemRed
    }
}
