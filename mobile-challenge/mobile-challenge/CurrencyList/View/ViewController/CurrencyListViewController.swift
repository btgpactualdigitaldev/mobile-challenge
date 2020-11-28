//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    var currencyListView: CurrencyListView {
        return view as! CurrencyListView
    }
    weak var coordinator: CurrencyListCoordinator?
    var manager: CurrencyListManager
    var tagButton: TagButton
    var typeSort: TypeSort
    var currenciesQuotation: [CurrencyQuotation] = []
    var viewModel: CurrencyListViewModel
    
    init() {
        self.viewModel = CurrencyListViewModel()
        self.manager = CurrencyListManager(viewModel: viewModel)
        self.tagButton = .origin
        self.typeSort = .code
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = CurrencyListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpClosures()
        setUpNavigation()
        setUpTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        coordinator?.didFinish()
    }
    
    func setUpTableView() {
        currencyListView.searchBar.delegate = manager
        currencyListView.tableView.delegate = manager
        currencyListView.tableView.dataSource = manager
        manager.tableView = currencyListView.tableView
    }
    
    func setUpNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: CurrencyListColors.currencyTitle.color ?? .blue]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: CurrencyListColors.currencyTitle.color ?? .blue]
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = CurrencyListStrings.title.text
        
        navigationController?.navigationBar.backgroundColor = AppColors.appBackground.color
        navigationController?.navigationBar.tintColor = CurrencyListColors.currencyTitle.color
       
        navigationItem.rightBarButtonItem = getBarButton()
    }
    
    func getBarButton() -> UIBarButtonItem{
        return UIBarButtonItem(title: typeSort.title, style: .plain, target: self, action: #selector(changeTypeSort))
    }
    
    @objc func changeTypeSort(sender: UIBarButtonItem) {
        typeSort = typeSort == TypeSort.code ? .name : .code
        sender.title = typeSort.title
        
        let sortedCurrencies = viewModel.sortArray(by: typeSort, currenciesQuotation: self.currenciesQuotation)
        manager.currenciesDict = sortedCurrencies
        manager.tableView?.reloadData()
    }
}

private extension CurrencyListViewController {
    func setUpClosures() {
        self.manager.selectedCurrency = { currencyQuotation in
            self.coordinator?.didFinish(currencyQuotation: currencyQuotation, tagButton: self.tagButton)
        }
    }
}

extension CurrencyListViewController: CurrenciesQuotationDelegate {
    func didFinishFetchQuotations(currenciesQuotation: [CurrencyQuotation], tagButton: TagButton) {
        self.tagButton = tagButton
        self.currenciesQuotation = currenciesQuotation
        
        let sortedCurrencies = self.viewModel.sortArray(by: self.typeSort, currenciesQuotation: currenciesQuotation)
        self.manager.currenciesDict = sortedCurrencies
        self.manager.state = .normal
            
        DispatchQueue.main.async {
            self.manager.tableView?.reloadData()
        }
    }
    
    func didFinishFetchQuotationsWithError(error: CurrencyError) {
        let alert = UIAlertController(title: "Ocorreu um Erro", message: "\(error.localizedError)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Continuar", style: .default)
        alert.addAction(action)
        
        if ((manager.currenciesDict.first?.isEmpty) != nil) {
            manager.state = .empty
        }
        
        DispatchQueue.main.async {
            self.manager.tableView?.reloadData()
            self.present(alert, animated: true)
        }
    }
}
