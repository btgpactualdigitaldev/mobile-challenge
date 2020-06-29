//
//  CurrencyListViewController.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    //MARK: Logical Properties
    
    private(set) var finishCallback: CurrencyIdCallback
    
    private(set) var factory: CurrencyTableViewFactory?
    
    private(set) var dataSource: DefaultTableViewOutput?
    
    private(set) var viewModel: CurrencyListViewModelProtocol?
    
    //MARK: UI Properties
    
    private lazy var tableView: CurrencyListTableView = {
        return CurrencyListTableView(frame: .zero)
    }()
    
    private lazy var sortSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(frame: .zero)
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.addTarget(self, action: #selector(didSearchTextFieldChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton))
    }()

    private lazy var errorView: ErrorView = {
        return ErrorView(frame: .zero, errorMessage: .empty)
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(frame: .zero)
    }()
    
    private lazy var mainView: CurrencyListView = {
        let sortView = SortView(frame: .zero,
                                segmentedControl: sortSegmentedControl,
                                textField: searchTextField)
        return CurrencyListView(frame: .zero,
                                tableView: tableView,
                                errorView: errorView,
                                activityView: activityView,
                                sortView: sortView)
    }()
    
    //MARK: Lifecycle methods
    
    init(finishCallback: @escaping CurrencyIdCallback) {
        self.finishCallback = finishCallback
        super.init(nibName: nil, bundle: nil)
        setupController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrencies()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
}

//MARK:

extension CurrencyListViewController: DefaultTableViewOutputDelegate {
    
    func didSelectRow(indexPath: IndexPath) {
        viewModel?.didSelectCurrency(index: indexPath.row)
    }
}

extension CurrencyListViewController {
    
    private func fetchCurrencies() {
        activityView.isHidden = false
        viewModel?.fetchCurrencies()
    }
    private func setupController() {
        title = Constants.Titles.currencyListTitle
        viewModel = CurrencyListViewModel(                                          delegate: self)
    }
    
    private func setupDataSource() {
        guard let sections = factory?.buildSections() else { return }
        dataSource = DefaultTableViewOutput(sections: sections)
        dataSource?.delegate = self
    }
    
    private func setupTableView() {
        guard let dataSource = dataSource else { return }
        tableView.assignProtocols(to: dataSource)
    }
    
    private func setupFactory() {
        guard let viewModel = viewModel else { return }
        factory = CurrencyTableViewFactory(viewModel: viewModel, tableView: tableView)
    }
    
    private func refreshList() {
        setupFactory()
        setupDataSource()
        setupTableView()
        
        DispatchQueue.main.async {
            self.activityView.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        title = Constants.Titles.currencyListTitle
        setupTableView()
        refreshList()
        viewModel?.fetchCurrencies()
    }
    
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didSearchTextFieldChange() {
        guard let text = searchTextField.text else { return }
        viewModel?.filterContentForSearchText(text)
    }
    
    @objc
    private func didChangeSegmentedControlValue() {
        viewModel?.sortCurrencyList(withTag: sortSegmentedControl.selectedSegmentIndex)
    }
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func didFetchCurrencies() {
        refreshList()
    }
    
    func didFetchSelectedCurrency(id: String) {
        navigationController?.popViewController(animated: true)
        finishCallback(id)
    }
    
    func didGetError(_ error: String) {
        mainView.displayError(withMessage: error)
    }
}

