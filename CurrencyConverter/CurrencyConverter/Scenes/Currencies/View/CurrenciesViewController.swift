//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

class CurrenciesViewController: UIViewController {
    
    weak var coordinator: CurrenciesCoordinator?
    var viewModel: CurrenciesViewModelProtocol
    var currenciesView: CurrenciesView
    var isInitial: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = currenciesView
        viewModel.onLoad()
        setupNavigationBar()
    }
    
    init(viewModel: CurrenciesViewModel) {
        self.viewModel = viewModel
        self.currenciesView = CurrenciesView(viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
        self.currenciesView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Functions
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Moedas"
    }

}

    // MARK: - Extensions

extension CurrenciesViewController: CurrenciesViewDelegate {
    func didSelectCurrency(currency: String) {
        coordinator?.didSelectCurrency(currency: currency, isInitial: isInitial)
    }
    
}
