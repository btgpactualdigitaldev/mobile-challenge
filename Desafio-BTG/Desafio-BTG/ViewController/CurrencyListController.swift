//
//  CurrencyListController.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class CurrencyListController: BaseViewController, DismissScreen, UISearchBarDelegate {
    
    // MARK: - Properties
    
    let kNameList = "coin list"
    let kError = "Error"
    let KInfoError = "The list of currencies could not be loaded. Please try again later."
    let KAlertSerchBar = "please insert a valid country"
    
    var viewModel: CurrencyViewModel?
    lazy var mainView = CurrencyListView(viewModel: viewModel)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestsApi()
        setupUI()
        mainView.delegate = self
        mainView.alertAction = alertActionSearchBar
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - Private functions
    
    private func fetchValue() {
        self.viewModel?.fetchCurrentValue { [weak self] success in
            guard let self = self else { return }
            if success {
                self.mainView.tableView.reloadData()
            } else {
                self.handleError()
            }
        }
    }
    
    private func fetchDetails() {
        self.viewModel?.fetchDetails { [weak self] success in
            guard let self = self else { return }
            if success {
                self.mainView.tableView.reloadData()
            } else {
                self.handleError()
            }
        }
    }
    
    private func requestsApi() {
        fetchValue()
        fetchDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = kNameList
        setupNavigation()
    }
    
    private func handleError() {
        self.showAlert(alertText: kError, alertMessage: KInfoError)
    }
    
    func dismissScreenTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func alertActionSearchBar() {
        showAlert(alertText: kError, alertMessage: KAlertSerchBar)
    }
}
