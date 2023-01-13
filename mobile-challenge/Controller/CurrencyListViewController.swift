//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import UIKit

protocol SelectCurrencyDelegate: class {
    func getSelectCurrency(type: TypeConverter, currency: Currency) -> Void
}

enum TypeConverter: String {
    case origin
    case destiny
}

class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchCurrencies: UISearchBar!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var viewModel: CurrencyListViewModel
    private let cellIdentifier = "currencyCell"
    var delegate: SelectCurrencyDelegate?
    
    init(type: TypeConverter) {
        self.viewModel = CurrencyListViewModel(type: type)
        super.init(nibName: "CurrencyListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        
        setupSegmentControl()
        setupTableView()
        setupSearchBar()
        fetchCurrencyList()
    }
    
    func setupTableView() -> Void {
        tableView.register(CurrencyUiTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupSearchBar() -> Void {
        self.searchCurrencies.delegate = self
    }
    
    func setupSegmentControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {

        switch OrderByCurrency(rawValue: sender.selectedSegmentIndex) {
        case .code:
            viewModel.orderBy(order: .code)
            tableView.reloadData()
        case .description:
            viewModel.orderBy(order: .description)
            tableView.reloadData()
        case .none:
            self.showAlert(message: ErrorHandler.notFound.rawValue)
        }
    }
    
    func fetchCurrencyList() {
        
        CurrencyAPI.shared.fetchCurrencyList { (result) in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.viewModel.setCurrenciesArray(currencyList: list)
                    self.tableView.reloadData()
                }
            case .error(let error):
                self.showAlert(message: error.rawValue)
            }
        }
    }
}

// MARK: TablewView

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currenciesFilter.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentSelect = viewModel.currenciesFilter[indexPath.row]
        
        delegate?.getSelectCurrency(type: viewModel.typeConverter, currency: currentSelect)
        
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CurrencyUiTableViewCell
        else { return CurrencyUiTableViewCell() }
        
        let currentCurrency = viewModel.currenciesFilter[indexPath.row]
        
        cell.setup(currency: currentCurrency)
        
        return cell
    }
}

// MARK: SearchBar
extension CurrencyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.viewModel.filterCurrencies(search: searchText.uppercased())
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.viewModel.filterCurrencies()
        tableView.reloadData()
    }
}
