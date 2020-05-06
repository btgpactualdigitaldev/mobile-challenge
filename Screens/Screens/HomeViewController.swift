//
//  HomeViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Combine
import Models
import Service

class HomeViewController: UIViewController, Drawable {
    
    private let homeView = HomeView()
    override func loadView() { view = homeView }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    var coordinator: Coordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.draw()
        draw()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
        homeView.delegate = self
    }
    
    func stylizeViews() {
        homeView.otherCurrenciesTableView.refreshControl?.tintColor = .init(white: 1, alpha: 0.8)
    }
    
    func createViewsHierarchy() {
        let refreshControl = UIRefreshControl()
        homeView.otherCurrenciesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    }
    
    
    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        refresh()
    }
}

extension HomeViewController: CurrencyPairDelegate {
    func currencyPair(_ sender: HomeView.Header.SelectedCurrencyPair, didTouch currency: CurrencyPairElement) {
        viewModel.selectedCurrencyPair = currency
        coordinator.present(from: self)
    }
}

extension HomeViewController {
    private func refresh() {
        if !(homeView.otherCurrenciesTableView.refreshControl?.isRefreshing ?? false) && homeView.otherCurrencies.isEmpty {
            let refreshControl = homeView.otherCurrenciesTableView.refreshControl!
            refreshControl.beginRefreshing()
            homeView.otherCurrenciesTableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.height), animated: true)
        }
        
        viewModel.quotesPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.alert(error)
                case .finished:
                    break
                }
            }) { (model) in
                    self.homeView.quote = .init(
                        value: String(format: "%.2f", arguments: [model.default.model.value]),
                        firstCurrency: model.default.model.first,
                        secondCurrency: model.default.model.second,
                        lastUpdate: "Updated \(model.default.updatedAt.elapsedTime()) ago")
                let transformed = model.quotes.map { quote in
                    HomeView.Cell.Model(
                        value: String(format: "%.2f", arguments: [quote.model.value]),
                        currenciesPair: "\(quote.model.first) to \(quote.model.second)",
                        lastSeen: quote.updatedAt.formattedHour())
                }
                self.homeView.otherCurrencies = transformed
                self.homeView.otherCurrenciesTableView.refreshControl?.endRefreshing()
            }.store(in: &cancellables)
    }
    
}
