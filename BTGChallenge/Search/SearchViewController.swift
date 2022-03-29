//
//  SearchViewController.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit

class SearchViewController: UIViewController {

    let theView: SearchView
    var viewModel = SearchViewModel()

    init(viewModel: SearchViewModel = SearchViewModel()) {
        self.viewModel = viewModel
        self.theView = SearchView(viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
        theView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = theView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fechCurrencys()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController = SearchBarViewController(buttonScopes: [], self)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension SearchViewController: SearchBarDelegate {
    func textDidChangeSearchController(_ text: String, _ scope: Int) {
        viewModel.searchedText.onNext(text)
    }
}


extension SearchViewController: SearchDelegate {
    func currencieSelectedClicked(_ cell: CurrencyCellView) {
        guard let acronym = cell.acronym else { return }
        PeformNavigation.navigate(event: SearchCoordinatorDestinys.backToConversion(acronym: acronym))
    }
}

