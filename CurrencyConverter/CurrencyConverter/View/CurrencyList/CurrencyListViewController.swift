//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

protocol CurrencyListViewControllerDelegate: class {
    func didSelectCurrency(selectedCurrency: Currency)
}

class CurrencyListViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = CurrencyListView()
    private lazy var viewModel = CurrencyListViewModel()
    
    weak var coordinator: MainCoordinator?
    
    weak var delegate: CurrencyListViewControllerDelegate?
    
    private var dataSource: CurrencyListDataSource? {
        didSet {
            guard let validDataSource = dataSource else {
                return
            }
            
            validDataSource.didSelectCurrency = { [weak self] selectedCurrency in
                self?.didSelectCurrency(selectedCurrency: selectedCurrency)
            }
            
            // Update Table View
            DispatchQueue.main.async { [weak self] in
                self?.baseView.tableView.dataSource = validDataSource
                self?.baseView.tableView.delegate = validDataSource
                self?.baseView.tableView.reloadData()
            }
        }
    }
    
    
    
    
    // MARK: - Initialization
    init(selectCurrencyDelegate: CurrencyListViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = selectCurrencyDelegate
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View Model
        viewModel.delegate = self
        viewModel.fetchCurrencies()
    }
}


// MARK: - CurrencyListViewModelDelegate
extension CurrencyListViewController: CurrencyListViewModelDelegate {
    func didReceiveCurrencies() {
        self.dataSource = CurrencyListDataSource(currencies: viewModel.currencies)
    }
    
    func didReceiveError(error: Error) {
        guard let detectedError = error as? NetworkError else {
            return
        }
        
        // TODO: Handle Errors
        var alertMessage = String()
        
        if detectedError == .networkUnavailable {
            alertMessage = "Sem conexão com a internet!"
        } else {
            alertMessage = "Houve um error na conexão com o servidor!"
        }
        
        let alertManager = AlertManager()
        let alert = alertManager.createGenericAlert(title: "Temos um probleminha...", message: alertMessage, buttonTitle: "Ok", completionButtonClicked: { [weak self] _ in
            self?.coordinator?.exitCurrentScreen()
        })
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - Handle Selected Currency
extension CurrencyListViewController {
    private func didSelectCurrency(selectedCurrency: Currency) {
        delegate?.didSelectCurrency(selectedCurrency: selectedCurrency)
        coordinator?.exitCurrentScreen()
    }
}

