//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 30/09/21.
//

import UIKit

final class CurrencyListView: UIView {
    
    var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.separatorStyle = .singleLine
        tbl.rowHeight = UITableView.automaticDimension
        tbl.backgroundColor = .white
        return tbl
    }()
    
    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        setupTableView(delegate: delegate, dataSource: dataSource)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: String(describing: CurrencyCell.self))
    }
    
}

// MARK: - View Configuration Methods
extension CurrencyListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([tableView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
    }
    
}
