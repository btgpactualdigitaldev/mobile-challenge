//
//  CurrencyPickerViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit
import os.log

/// Representation of the app's currency picking screen.
final class CurrencyPickerViewController: UIViewController {
    // - MARK: Properties

    /// Representation of supported currencies.
    @AutoLayout private var currencyTableView: UITableView

    /// The `ViewModel` for this type.
    private let viewModel: CurrencyPickerViewModel

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter viewModel: The `ViewModel` for this type.
    init(viewModel: CurrencyPickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        os_log("CurrencyPickerViewController initialized.", log: .appflow, type: .debug)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //- MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpViewModel()
        setUpViews()
        layoutConstraints()
    }

    @objc private func cancelSelection() {
        os_log("CurrencyPickerViewController requested for dismissal. No changes to currency.", log: .appflow, type: .debug)
        dismiss(animated: true, completion: nil)
    }

    //- MARK: ViewModel setup
    private func setUpViewModel() {
        os_log("CurrencyPickerViewController's ViewModel setup.", log: .appflow, type: .debug)
        viewModel.delegate = self
        title = viewModel.title
    }

    // - MARK: Views setup
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        currencyTableView.backgroundColor = .systemBackground
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
    }

    private func setUpNavigationItem() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(cancelSelection))
        navigationItem.rightBarButtonItem = cancelButton
    }

    // - Layout
    private func layoutConstraints() {
        view.addSubview(currencyTableView)

        let safeAreaGuides = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            currencyTableView.centerXAnchor.constraint(equalTo: safeAreaGuides.centerXAnchor),
            currencyTableView.centerYAnchor.constraint(equalTo: safeAreaGuides.centerYAnchor),
            currencyTableView.widthAnchor.constraint(equalTo: safeAreaGuides.widthAnchor),
            currencyTableView.heightAnchor.constraint(equalTo: safeAreaGuides.heightAnchor)
        ])
    }
}

// - MARK: UITableViewDelegate
extension CurrencyPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        os_log("CurrencyPickerViewController requested for dismissal after currency was picked.", log: .appflow, type: .debug)
        viewModel.currentCurrency = indexPath
        dismiss(animated: true, completion: nil)
    }

}

//- MARK: UITableViewDataSource
extension CurrencyPickerViewController: UITableViewDataSource {
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
        if indexPath == viewModel.currentCurrency {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}

//- MARK: ViewModel delegate
extension CurrencyPickerViewController: CurrencyPickerViewModelDelegate {
    func didSelectCurrency(_ indexPath: IndexPath, previous: IndexPath) {
        currencyTableView.reloadRows(at: [indexPath, previous], with: .fade)
    }
}
