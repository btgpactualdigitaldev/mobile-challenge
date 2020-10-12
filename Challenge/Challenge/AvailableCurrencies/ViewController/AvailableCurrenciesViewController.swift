//
//  AvailableCurrenciesViewController.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

internal final class AvailableCurrenciesViewController: UIViewController {
    
    internal var theView: AvailableCurrencyView {
        return view as! AvailableCurrencyView
    }
    internal var orderedList: [Dictionary<String, String>.Element] = []
    internal var filteredList: [Dictionary<String, String>.Element] = []
    internal var isSearching: Bool = false

    override func loadView() {
        super.loadView()
        let availView = AvailableCurrencyView()
        availView.tableView.separatorStyle = .none
        availView.tableView.delegate = self
        availView.tableView.dataSource = self
        availView.tableView.register(AvailableCurrencyCell.self, forCellReuseIdentifier: cellId)
        availView.searchBar.delegate = self
        view = availView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startLoading(onView: view)
        requestList()
    }
    
    internal func requestList() {
        ApiRequests.request(.availableList) { [weak self] (response: CurrencyList?, error: String?) in
            if let response = response {
                self?.orderedList = Array(response.currencies.sorted{ $0.key < $1.key })
                DispatchQueue.main.async { [weak self] in
                    (self?.view as! AvailableCurrencyView).tableView.reloadData()
                    self?.stopLoading()
                }
            }
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.stopLoading()
                    self?.showErrorAlert(message: error)
                }
            }

        }
    }

}
