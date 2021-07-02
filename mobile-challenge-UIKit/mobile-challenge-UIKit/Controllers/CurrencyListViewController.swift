//
//  CurrencyListViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController, ViewCodable {

    private weak var coordinator: (MainCoordinator & CurrencyChoosing)?
    private var viewModel: CurrencyListViewModel
    private let tableViewDataSource = CurrencyListTableViewDataSource()
    private let tableViewDelegate = TableViewDelegate()
    private var onSelectCurrency: (Currency) -> Void = { _ in }
    private var currencyType: CurrencyConverterViewModel.CurrencyType

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true

        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate

        return tableView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: LiteralText.name, at: 0, animated: false)
        segmented.insertSegment(withTitle: LiteralText.code, at: 1, animated: false)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(onSegmentSelected(_:)), for: .valueChanged)

        return segmented
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()

        return activityIndicator
    }()

    init(coordinator: (MainCoordinator & CurrencyChoosing),
         viewModel: CurrencyListViewModel,
         currencyType: CurrencyConverterViewModel.CurrencyType,
         onSelectCurrency: @escaping (Currency) -> Void) {
        self.viewModel = viewModel
        self.currencyType = currencyType
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.onSelectCurrency = onSelectCurrency
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstraints()
    }

    @objc private func onSegmentSelected(_ segment: UISegmentedControl) {
        viewModel.sort(by: segment.selectedSegmentIndex)
    }

    func setUp() {
        view.backgroundColor = DesignSystem.Color.background
        navigationItem.title = currencyType == .origin
            ? LiteralText.originViewControllerTitle
            : LiteralText.targetViewControllerTitle
        navigationItem.titleView = segmentedControl

        setUpSearchController()

        viewModel.onUpdate = { [weak self] in
            self?.activityIndicator.removeFromSuperview()
            self?.tableView.isHidden = false
            self?.updateUI()
        }

        tableViewDataSource.setNumberOfRows = { [weak self] in
            guard let self = self else { return 0 }
            return self.viewModel.getCurrenciesSize()
        }
        tableViewDataSource.getCurrencyForRowAt = { [weak self] row in
            return self?.viewModel.getCurrency(for: row)
        }

        tableViewDelegate.didSelectRowAt = { [weak self] row in
            guard let self = self else { return }
            self.onSelectCurrency(self.viewModel.getCurrency(for: row))
            self.coordinator?.goBack()
        }

    }

    /// SetUp the searchController
    func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }

    func setConstraints() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func updateUI() {
        tableView.reloadData()
    }
}

extension CurrencyListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        viewModel.filter(by: text)
    }

}
