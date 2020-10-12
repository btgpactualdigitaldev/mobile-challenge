//
//  AvailableCurrencyView.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class AvailableCurrencyView: UIView {
    
    internal var tableView: UITableView!
    internal var searchBar: UISearchBar!

    override init(frame: CGRect) {
        tableView = UITableView()
        searchBar = UISearchBar()
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AvailableCurrencyView: ViewCodable {

    func buildView() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfig() {
        searchBar.placeholder = "Search for currency"
        searchBar.textField?.addDoneButtonOnKeyboard()

        tableView.isEditing = false
        tableView.allowsSelection = false 
    }
    
    func render() {
        
    }
}

extension UISearchBar {
    var textField: UITextField? {
        return getTextField(inViews: subviews)
    }

    private func getTextField(inViews views: [UIView]?) -> UITextField? {
        guard let views = views else { return nil }

        for view in views {
            if let textField = (view as? UITextField) ?? getTextField(inViews: view.subviews) {
                return textField
            }
        }

        return nil
    }
}
