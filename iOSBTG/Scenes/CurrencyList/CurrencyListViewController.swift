//
//  CurrencyListViewController.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

protocol CurrencyListDisplayLogic: class {
    func showEmptyState()
    func renderCurrenciesList(viewModel: CurrencyList.Fetch.ViewModel)
}

final class CurrencyListViewController: UIViewController {
    
    // MARK:  Properties
        
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .gray
        return indicator
    }()
    
    private lazy var emptyView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private(set) var viewState: ViewState = .loading {
        didSet {
            switch viewState {
            case .loaded:
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.tableView.isHidden = false
                    self.emptyView.alpha = 0.0
                }
                break
            case .loading:
                DispatchQueue.main.async {
                    self.loadingIndicator.startAnimating()
                    self.tableView.isHidden = true
                    self.emptyView.alpha = 0.0
                }
                break
            case .empty:
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.tableView.isHidden = true
                    self.emptyView.alpha = 1.0
                }
                break
            }
        }
    }
    
    var interactor: CurrencyListBusinessLogic?
    var router: (NSObjectProtocol & CurrencyListRoutingLogic)?
    private let reuseIdentifier = "listcell"
    private var currenciesList: CurrencyList.Fetch.ViewModel?
    
    // MARK: Initializers
    
    init(configurator: CurrencyListConfigurator = CurrencyListConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
        setUpSubViews()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CurrencyListConfigurator.shared.configure(viewController: self)
    }
    
    deinit {
        currenciesList = nil
    }
    
    // MARK: ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewState != .loaded {
            viewState = .loading
        }
        currenciesList = nil
        interactor?.fetchListCurrencies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navTopItem = navigationController?.navigationBar.topItem {
            navTopItem.titleView = .none
            navTopItem.title = "List"
        }
    }
    
    // MARK: Class Funcitons
    
    private func setUpSubViews() {
        view.addSubview(loadingIndicator)
        view.addSubview(emptyView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 35.0),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 35.0),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
}

// MARK: - CurrencyListDisplayLogic

extension CurrencyListViewController: CurrencyListDisplayLogic {
    
    func renderCurrenciesList(viewModel: CurrencyList.Fetch.ViewModel) {
        currenciesList = viewModel
        viewState = .loaded
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showEmptyState() {
        viewState = .empty
    }
    
}

// MARK: - CurrencyList TableViewDataSource

extension CurrencyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesList?.currencies.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let currency = currenciesList
        cell.textLabel?.text = currency?.orderedList[indexPath.row]
        return cell
        
    }

}

// MARK: - CurrencyList TableViewDelegate

extension CurrencyListViewController: UITableViewDelegate {
    
    
}
