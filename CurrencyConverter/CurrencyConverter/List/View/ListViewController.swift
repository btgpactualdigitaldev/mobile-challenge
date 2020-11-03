//
//  ListViewController.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

protocol ListDelegate: class {
    func didSelectCurrency(_ currency: Currecy, type: CurrencyType)
}

class ListViewController: UIViewController, StateTransition {

    var loadingView: UIView = LoadingView()
    private let viewModel: ListViewModel
    weak var delegate: ListDelegate?
    
    // MARK: - Layout Vars
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Style.List.closeText, style: .done, target: self, action: #selector(close))
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar().useConstraint()
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.tintColor = .white
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.keyboardAppearance = .dark
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var emptySearch: UILabel = {
        let label = UILabel().useConstraint()
        label.font = Style.highlightFont
        label.textColor = Style.defaultSecondaryTextColor
        label.text = Style.List.emptySearch
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped).useConstraint()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.description())
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorInset = Style.List.tableViewSeparatorInset
        tableView.contentInset = Style.List.tableViewInset
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        viewModel = ListViewModel(type: .origin)
        super.init(coder: coder)
    }
    
    init(type: CurrencyType) {
        viewModel = ListViewModel(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loading(animated: false)
        viewModel.delegate = self
        viewModel.availableCurrrencies()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        title = Style.List.title
        navigationItem.setRightBarButton(closeButton, animated: false)
        view.backgroundColor = .black
        view.addSubview(tableView)
        view.addSubview(searchBar)
        view.addSubview(emptySearch)
        
        searchBar
            .top(anchor: view.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: view.safeAreaLayoutGuide.leadingAnchor, constant: Style.defaultCloseLeading)
            .trailing(anchor: view.safeAreaLayoutGuide.trailingAnchor, constant: Style.defaultCloseTrailing)
            .height(constant: Style.List.searchHeight)
        
        emptySearch
            .top(anchor: searchBar.bottomAnchor, constant: Style.defaultCloseTop)
            .leading(anchor: view.safeAreaLayoutGuide.leadingAnchor, constant: Style.defaultCloseLeading)
            .trailing(anchor: view.safeAreaLayoutGuide.trailingAnchor, constant: Style.defaultCloseTrailing)
        
        tableView
            .top(anchor: searchBar.bottomAnchor)
            .leading(anchor: view.safeAreaLayoutGuide.leadingAnchor)
            .trailing(anchor: view.safeAreaLayoutGuide.trailingAnchor)
            .bottom(anchor: view.bottomAnchor)
    }
    
    // MARK: - Actions
    @objc private func close() {
        dismiss(animated: true)
    }
}

// MARK: - View Model
extension ListViewController: ListViewModelDelegate {
    func onListCurrenciesUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.emptySearch.isHidden = self?.viewModel.currenciesDisplayed.isEmpty == false
            self?.tableView.reloadData()
            self?.content()
        }
    }
    
    func onError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            let retry = {
                self?.loading()
                self?.viewModel.retry?()
            }
            self?.custom(view: ErrorView(text: error, retry: retry))
        }
    }
}

// MARK: - Serach
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.serach(for: searchText)
    }
}

// MARK: - TableView
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currenciesDisplayed.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Style.List.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.description(), for: indexPath) as? CurrencyTableViewCell
        cell?.title = viewModel.currenciesDisplayed[indexPath.row].code
        cell?.subtitle = viewModel.currenciesDisplayed[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = viewModel.currenciesDisplayed[indexPath.row]
        delegate?.didSelectCurrency(currency, type: viewModel.type)
        dismiss(animated: true)
    }
}
