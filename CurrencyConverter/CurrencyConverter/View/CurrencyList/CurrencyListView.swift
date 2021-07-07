//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

class CurrencyListView: UIView {
    // MARK: - Views
    let searchController: UISearchController = UISearchController()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.Cell.currencyCell)
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:
extension CurrencyListView: ViewCodable {
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func setupAditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
    
    
}
