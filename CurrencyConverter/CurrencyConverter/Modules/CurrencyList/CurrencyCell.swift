//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 30/09/21.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    
    var container: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfos(_ model: String) {
        label.text = model
    }
    
}

extension CurrencyCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([container])
        container.addArrangedSubview(label)
    }
    
    func setupConstraints() {
        [
            container.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
        ].activate()
    }
    
    func configureViews() {
    }
}
