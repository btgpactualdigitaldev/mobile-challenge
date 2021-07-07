//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

class CurrencyListViewController: UIViewController {

    // MARK:- Attributes
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar moeda"
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()
    
    var dataSource: CurrenciesDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            
            dataSource.didSelectCurrency = { [weak self] selectedCurrency in
                guard let self = self else { return }
                self.setSelectedCurrency(selectedCurrency)
            }
            
            DispatchQueue.main.async {
                self.tableView.dataSource = dataSource
                self.tableView.delegate = dataSource
                self.reloadTableViewData()
            }
        }
    }
    
    var safearea: UILayoutGuide!
    
    var orderCurrencies: OrderCurrencies = .code
    lazy var orderBarItem: UIBarButtonItem = createOrderButton(orderCurrencies)
    
    let viewModel: CurrencyListViewModel
    let converterViewModel: ConverterViewModel
    let buttonTapped: ButtonTapped
    
    //MARK:- init
    init(viewModel: CurrencyListViewModel, converterViewModel: ConverterViewModel, buttonTapped: ButtonTapped) {
        self.viewModel = viewModel
        self.converterViewModel = converterViewModel
        self.buttonTapped = buttonTapped
        
        super.init(nibName: nil, bundle: nil)
        
        safearea = view.layoutMarginsGuide
        
        setupUI()
        setupViews()
        setupNavigationBarBar()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchViewModelCurrencies()
    }
        
    // MARK:- FetchViewModelCurrencies
    func fetchViewModelCurrencies() {
        hideActivityIndicator()
        showActivityIndicator()
        self.viewModel.fetchCurrencies() { result in
            switch result {
            case .success(let currencies):
                self.dataSource = CurrenciesDataSource(currencies: currencies)
                self.viewModel.fetchValuesInDollar { result in
                    switch result {
                    case .success(let date):
                        self.dataSource?.dateExchange = date
                        self.reloadTableViewData()
                    case .failure(let error):
                        self.showAlert(title: error.errorDescription)
                    }
                }
            case .failure(let error):
                switch error {
                case .offline:
                    guard let dateExchange = self.viewModel.dateExchange else {
                        DispatchQueue.main.async {
                            if let currencies = self.viewModel.retrieveCurrencies() {
                                self.setupDataSource(currencies: currencies,
                                                     dateExchange: self.viewModel.dateExchange ?? Date())
                            }
                            else {
                                self.showAlert(title: error.errorDescription)
                            }
                        }
                        return
                    }
                    
                    self.setupDataSource(currencies: self.viewModel.currencies,
                                         dateExchange: dateExchange)
                default:
                    self.showAlert(title: error.errorDescription)
                }
            }
            self.hideActivityIndicator()
        }
    }
    
    // MARK:- CreateNavigationBatButton
    func createOrderButton(_ title: OrderCurrencies) -> UIBarButtonItem {
        let button = UIButton()
        button.setTitle(title.rawValue, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    @objc func orderButtonTapped() {
        orderCurrencies = orderCurrencies == .name ? .code : .name
        navigationItem.rightBarButtonItem = createOrderButton(orderCurrencies)
        
        viewModel.orderCurrencies(by: orderCurrencies)
        setupDataSource(currencies: self.viewModel.currencies, dateExchange: self.viewModel.dateExchange ?? Date())
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideActivityIndicator()
        }
    }
    
    //MARK:- Show alert
    func showAlert(title: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Tentar novamente", style: .default) { _ in
            self.fetchViewModelCurrencies()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(tryAgainAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showOkAlert(title: String?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    //MARK:- Set selected currency
    func setSelectedCurrency(_ currency: CurrencyModel) {
        let USD = Identifier.Currency.USD.rawValue
        
        if buttonTapped == .source {
            converterViewModel.source = currency
            if currency.code != USD {
                converterViewModel.dollar = viewModel.getDollar()
            }
        }
        else if buttonTapped == .destiny {
            converterViewModel.destiny = currency
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK:- Setups
extension CurrencyListViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupNavigationBarBar() {
        navigationItem.rightBarButtonItem = orderBarItem
    }
    
    func setupTableView() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupDataSource(currencies: [CurrencyModel], dateExchange: Date) {
        dataSource = CurrenciesDataSource(currencies: currencies)
        dataSource?.dateExchange = dateExchange
    }
}

//MARK:- UISearchBarDelegate
extension CurrencyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredCurrencies = viewModel.search(searchText, order: orderCurrencies)
        setupDataSource(currencies: filteredCurrencies, dateExchange: self.viewModel.dateExchange ?? Date())
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        setupDataSource(currencies: self.viewModel.currencies,
                        dateExchange: self.viewModel.dateExchange ?? Date())
    }
}

//MARK:- ViewCodable
extension CurrencyListViewController: ViewCodable {
    func setupHierarchyViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        setupSearchBarConstraints()
        setupTableViewConstraints()
    }
    
    func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safearea.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
