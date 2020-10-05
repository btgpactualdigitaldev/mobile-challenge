//
//  SupportedCurrenciesViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import UIKit
import os.log

/// Representation of the app's supported currencies.
final class SupportedCurrenciesViewController: UIViewController {
    //- MARK: Properties
    /// Representation of supported currencies.
    @AutoLayout private var currenciesTableView: UITableView

    /// The `ViewModel` for this type.
    private let viewModel: SupportedCurrenciesViewModel

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter viewModel: The `ViewModel` for this type.
    init(viewModel: SupportedCurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        os_log("SupportedCurrenciesViewController initialized.", log: .appflow, type: .debug)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //- MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currencies"
        setUpTableView()
        layoutConstraints()
    }

    //- MARK: Layout
    private func setUpTableView() {
        view.backgroundColor = .systemBackground
        currenciesTableView.dataSource = self
        currenciesTableView.backgroundColor = .systemBackground
        currenciesTableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
    }
    private func layoutConstraints() {
        view.addSubview(currenciesTableView)

        let safeAreaGuides = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            currenciesTableView.centerXAnchor.constraint(equalTo: safeAreaGuides.centerXAnchor),
            currenciesTableView.centerYAnchor.constraint(equalTo: safeAreaGuides.centerYAnchor),
            currenciesTableView.widthAnchor.constraint(equalTo: safeAreaGuides.widthAnchor),
            currenciesTableView.heightAnchor.constraint(equalTo: safeAreaGuides.heightAnchor)
        ])
    }
}

//- MARK: UITableViewDataSource
extension SupportedCurrenciesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .none
        cell.textLabel?.text = viewModel.currencyCodeAt(index: indexPath)
        cell.detailTextLabel?.text = viewModel.currencyNameAt(index: indexPath)
        return cell
    }
}
