//
//  CurrenciesController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class CurrenciesViewController: UIViewController {

    weak var coordinator: CurrenciesViewControllerDelegate?
    
    var currenciesViewModel: CurrenciesViewModel
    
    lazy var currenciesView: CurrenciesView = {
        let view = CurrenciesView(frame: self.view.frame)
        view.cancelBarButton.action = #selector(didTappedOnCancel)
        view.cancelBarButton.target = self
        
        view.currenciesTableView.delegate = currenciesTableViewDelegate
        view.currenciesTableView.dataSource = currenciesTableViewDataSource
        
        view.searchBarController.searchBar.delegate = searchBarDelegate
        return view
    }()
    
    private lazy var searchBarDelegate: CurrenciesSearchBarDelegate = {
        
        let delegate = CurrenciesSearchBarDelegate(currencies: currenciesViewModel.currencies)
        
        delegate.seachBarFilterDelegate = self
        
        return delegate
    }()
    
    lazy var currenciesTableViewDelegate: TableViewDelegate = {
        let delegate = TableViewDelegate()
        delegate.currencies = currenciesViewModel.currencies
        delegate.selectedCellDelegate = self
        
        return delegate
    }()
    
    lazy var currenciesTableViewDataSource: TableViewDataSource = {
        let dataSource = TableViewDataSource()
        dataSource.currencies = currenciesViewModel.currencies
        
        return dataSource
    }()
    
    func fetchAllCurrencies() {
        
        currenciesView.loadIndicator.startAnimating()
        
        currenciesViewModel.fetchAllCurrencies { [weak self] (result) in
            
            switch result {
            case .success(let currencies):
                self?.currenciesViewModel.currencies = currencies
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(text: error.errorDescription)
                }
            }
            
            DispatchQueue.main.async {
                self?.currenciesView.loadIndicator.stopAnimating()
                self?.updateTableViewData()
            }
        }
    }
    
    func updateTableViewData(){
        self.currenciesTableViewDelegate.currencies = currenciesViewModel.currencies
        self.currenciesTableViewDataSource.currencies = currenciesViewModel.currencies
        self.searchBarDelegate.currencies = currenciesViewModel.currencies
        self.currenciesView.currenciesTableView.reloadData()
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @objc private func didTappedOnCancel() {
        coordinator?.returnToExchangesView()
    }
    
    func setUp() {
        self.title = "Currencies"
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = currenciesView
        
        setUp()
        fetchAllCurrencies()
    }
    
    init() {
        self.currenciesViewModel = CurrenciesViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrenciesViewController: SelectedCellDelegate{
    func didSelectedCell(currencyCode: String) {
        coordinator?.didSelectedCurrency(currencyCode: currencyCode)
    }
}

extension CurrenciesViewController: SeachBarFilterDelegate{
    
    func didSearchCurrency(currencies: [String : String]) {
        self.currenciesTableViewDelegate.currencies = currencies
        self.currenciesTableViewDataSource.currencies = currencies
        
        self.currenciesView.currenciesTableView.reloadData()
    }
}
