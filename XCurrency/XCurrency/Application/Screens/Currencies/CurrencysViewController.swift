//
//  CurrencysViewController.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencysViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Attributes
    private let viewModel: CurrencysViewModel
    private var selectedCurrency: (Currency) -> Void = { _ in }
    private var alert: UIAlertController?

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigationBar()
        self.setupSearchController()
    }

    override func viewDidAppear(_ animated: Bool) {
        if self.viewModel.loading {
            self.showLoadingView()
        }
    }

    // MARK: Initializers
    init(currencysViewModel: CurrencysViewModel) {
        self.viewModel = currencysViewModel
        super.init(nibName: nil, bundle: nil)

        self.viewModel.updateErrorMessage = { [unowned self] in
            self.alert?.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: StringsDictionary.error, message: self.viewModel.errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: StringsDictionary.ok, style: .default, handler: self.alertHandler(alert:)))
            self.present(alert, animated: true, completion: nil)
        }

        self.viewModel.updateCurrencies = { [unowned self] in
            self.tableView.reloadData()
            self.alert?.dismiss(animated: true, completion: nil)
        }
    }

    deinit {
        print("")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = [StringsDictionary.name, StringsDictionary.code]
        self.navigationItem.searchController = searchController
    }

    private func alertHandler(alert: UIAlertAction) {
        self.viewModel.dismiss()
    }

    private func showLoadingView() {
        self.alert = UIAlertController(title: nil, message: StringsDictionary.pleaseWait, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        self.alert!.view.addSubview(loadingIndicator)
        self.present(self.alert!, animated: true, completion: nil)
    }

    private func setupTableView() {
        let nib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    private func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = StringsDictionary.back
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func getSelectedScopeIndexType(index: Int) -> CurrenciesOrder {
        return index == 0 ? .name : .code
    }

    // MARK: - Public Methods
    func setDelegate(selectedCurrency: @escaping (Currency) -> Void) {
        self.selectedCurrency = selectedCurrency
    }
}

// MARK: - TableViewDelegate
extension CurrencysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currency = self.viewModel.getCurrency(position: indexPath.row) {
            self.selectedCurrency(currency)
            self.viewModel.dismiss()
        }
    }
}

// MARK: - TableViewDataSource
extension CurrencysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.currenciesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CurrencyTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyTableViewCell {
            if let currency = self.viewModel.getCurrency(position: indexPath.row) {
                cell.setupCell(currency: currency)
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - SearchBarDelegate
extension CurrencysViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.viewModel.orderCurrenciesBy(self.getSelectedScopeIndexType(index: selectedScope))
    }
}

// MARK: - UISearchResultsUpdating
extension CurrencysViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        self.viewModel.filterCurrenciesBy(text: text)
    }
}
