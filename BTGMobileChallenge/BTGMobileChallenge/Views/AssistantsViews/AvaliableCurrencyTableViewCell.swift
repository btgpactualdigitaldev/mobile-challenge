//
//  AvaliableCurrencyTableViewCell.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class AvaliableCurrencyTableViewCell: UITableViewCell {
	static let identifier = "AvaliableCurrencyTableViewCell"
	private let codeLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	func config(code: String, description: String) {
		codeLabel.text = code
		descriptionLabel.text = description
		
		self.contentView.addSubview(codeLabel)
		self.contentView.addSubview(descriptionLabel)
		
		codeLabel.anchor(
			left: (contentView.leftAnchor, 20),
			centerY: (contentView.centerYAnchor, 0)
		)
		
		descriptionLabel.anchor(
			left: (codeLabel.rightAnchor, 20),
			centerY: (contentView.centerYAnchor, 0)
		)
	}
}
