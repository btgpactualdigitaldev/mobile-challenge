//
//  CurrenciesViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import UIKit

class SupportedCurrenciesViewController: UIViewController, Storyboarded {

    var  viewModel: SupportedCurrenciesViewModel?
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.initSupportedCurrenciesScreen(tableView: tableView)
    }

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Strings.SupportedCurrenciesScreen.title
            titleLabel.tintColor = Colors.primaryColor
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tintColor = Colors.primaryColor
        }
    }

    // MARK: - Actions

    @IBAction func onPressBackButton(_ sender: Any) {
        viewModel?.isSearching = false
        navigationController?.popViewController(animated: true)
    }
}

extension SupportedCurrenciesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // Filter Dictionary
        if searchText.count > 0 && !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            viewModel?.supportedListSearch = viewModel?.filterSearchbarList(list: (viewModel?.supportedList)!, searchText: searchText)
            viewModel?.isSearching = true
        } else {
            viewModel?.isSearching = false
        }
        tableView.reloadData()
    }

    // Disable keyboard on Press Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SupportedCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel?.isSearching == true {
            return 1
        } else {
            return (viewModel?.supportedTitles.count)!
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if viewModel?.isSearching == true {
            return (viewModel?.supportedListSearch!.count)!
        } else {
            let listKey = viewModel?.supportedTitles[section]
            if let listValues = viewModel?.supportedListDictionary![listKey!] {
                return listValues.count
            } else {
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)

        if viewModel?.isSearching == true {
            cell.detailTextLabel?.text = viewModel?.supportedListSearch![indexPath.row].currencyCode
            cell.textLabel?.text = viewModel?.supportedListSearch![indexPath.row].currencyName
        } else {
            let itemKey = viewModel?.supportedTitles[indexPath.section]

            if let keyValues = viewModel?.supportedListDictionary![itemKey!] {
                cell.detailTextLabel?.text = keyValues[indexPath.row].currencyCode
                cell.textLabel?.text = keyValues[indexPath.row].currencyName
            }

            // Dismiss keyboard on Drag
            tableView.keyboardDismissMode = .onDrag
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel?.isSearching == true {
            return nil
        } else {
            return viewModel?.supportedTitles[section]
        }
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {

        if viewModel?.isSearching == true {
            return nil
        } else {
            return viewModel?.supportedTitles
        }
    }
}
