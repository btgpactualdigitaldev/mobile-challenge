//
//  CurrenciesViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 30/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Combine
import Models

class CurrenciesViewController: UINavigationController, Drawable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    let viewModel = CurrenciesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private weak var tableViewController: CurrenciesTableViewController!
    var coordinator: Coordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
        tableViewController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        cancellables.removeAll()
    }
    
    @objc private func handleRefresh(_ control: UIRefreshControl) {
        refresh()
    }
    
    func stylizeViews() {
        tableViewController.refreshControl?.tintColor = .init(white: 1, alpha: 0.8)
    }
    
    func createViewsHierarchy() {
        let tableViewController = CurrenciesTableViewController()
        self.tableViewController = tableViewController
        pushViewController(tableViewController, animated: false)
        
        let refreshControl = UIRefreshControl()
        tableViewController.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(handleGoBack(_:)))
        backButton.tintColor = .white
        tableViewController.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func handleGoBack(_ sender: UIBarButtonItem) {
        coordinator.dismiss(from: self)
    }
}

extension CurrenciesViewController: CurrenciesTableViewControllerDelegate {
    func controller(_ controller: CurrenciesTableViewController, didSelect currency: Currency) {
        viewModel.currencyPublisher.send(currency)
        coordinator.dismiss(from: self)
    }
}

extension CurrenciesViewController {
    private func refresh() {
        
        if !(tableViewController.refreshControl?.isRefreshing ?? false) {
            let refreshControl = tableViewController.refreshControl!
            refreshControl.beginRefreshing()
            tableViewController.tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.height), animated: true)
        }
        
        viewModel.currenciesPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.alert(error)
                case .finished:
                    self.tableViewController.refreshControl?.endRefreshing()
                }
            }) { currencies in
                self.tableViewController.currencies = currencies.sorted()
            }.store(in: &cancellables)
    }
}
