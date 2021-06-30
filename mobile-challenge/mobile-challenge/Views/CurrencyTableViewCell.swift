//
//  CurrencyTableViewCell.swift
//  mobile-challenge
//
//  Created by gabriel on 01/12/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: Data dependencies
    var name: String? {
        didSet {
            self.nameLabel.text = name
        }
    }
    
    var symbol: String? {
        didSet {
            self.symbolLabel.text = symbol
        }
    }
    
    // MARK: UI Elements
    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    // MARK: Setup methods
    /**
     Setup the cell UI and set the name and symbol of the Currency.
     
     - Parameter name: The name of the currency.
     - Parameter symbol: The symbol of the currency.
     */
    func setup(for name: String, and symbol: String) {
        setupUI()
        
        // Set variables
        self.name = name
        self.symbol = symbol
    }
    
    private func setupUI() {
        backgroundColor = .black
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray6
                
        // Add stack as subview of contentView
        contentView.addSubview(stack)
        
        // Add labels as subviews of stack
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(symbolLabel)
        
        setupStackConstraints()
    }
    
    func setupStackConstraints() {
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 30).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
