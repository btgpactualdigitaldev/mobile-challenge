//
//  ListTableViewCell.swift
//  MobileChallenge
//
//  Created by Vitor Gomes on 07/09/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"
    
    var initials = UILabel()
    var fullName = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onBindViewHolder(initial: String, fullName: String) {
        self.initials.text = initial
        self.fullName.text = fullName
    }
    
}

extension ListTableViewCell {
    func setupLayout() {
        
        contentView.addSubview(initials)
        initials.translatesAutoresizingMaskIntoConstraints = false
        initials.textColor = UIColor(red: 1/255, green: 23/255, blue: 97/255, alpha: 1.0)
        NSLayoutConstraint.activate([
            initials.topAnchor.constraint(equalTo: contentView.topAnchor),
            initials.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            initials.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentView.addSubview(fullName)
        fullName.translatesAutoresizingMaskIntoConstraints = false
        initials.textColor = UIColor(red: 1/255, green: 23/255, blue: 97/255, alpha: 1.0)
        NSLayoutConstraint.activate([
            fullName.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullName.leadingAnchor.constraint(equalTo: initials.trailingAnchor, constant: 16),
            fullName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
