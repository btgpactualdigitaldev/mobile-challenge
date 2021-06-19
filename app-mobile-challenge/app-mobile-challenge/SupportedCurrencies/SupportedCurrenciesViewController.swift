//
//  SupportedCurrenciesViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class SupportedCurrenciesViewController: ViewController<SupportedCurrenciesView> {

    // Properties
    
    private var viewModel: SupportedCurrenciesViewModel
    private var type: PickCurrencyType
    
    // Lifecycle

    init(viewModel: SupportedCurrenciesViewModel, type: PickCurrencyType) {
        self.type = type
        self.viewModel = viewModel
        super.init()
        self.contentView.setup(title: viewModel.title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // Setup

    func setup() {
        self.hideKeyboardWhenTappedAround()
        self.contentView.search.delegate = self
        self.contentView.currentyList.cdelegate = self
        self.setupButton()
    }
}

// Actions

extension SupportedCurrenciesViewController {
    private func setupButton() {
        contentView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc private func backTapped() {
        viewModel.backTapped()
    }
}

extension SupportedCurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        contentView.currentyList.filterBy(textSearched: textSearched)
    }
}

extension SupportedCurrenciesViewController: CurrencyListService {
    func choiced(list: List) {
        viewModel.choiced(currency: list, type: type)
    }
}
