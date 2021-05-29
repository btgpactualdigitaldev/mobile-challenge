//
//  CurrencyListView.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class CurrencyListView: UIView {

    var tableView: CurrencyTableView = {
        let tableView = CurrencyTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var sortSegmentedControl: UISegmentedControl {
        let items = ["Nome", "Código"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeSort), for: .valueChanged)
        return segmentedControl
    }
    
    var changeOrder: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didChangeSort() {
        changeOrder?()
        tableView.reloadData()
    }
    
}

extension CurrencyListView: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupAdditionalConfiguration() {
        tableView.tableHeaderView = sortSegmentedControl
    }
}
