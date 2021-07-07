//
//  ExchangeModalViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import UIKit

class ExchangeModalViewController: UIViewController {

    var selected: ButtonType?
    var viewModel = SelectItemModalViewModel(coreData: CoreDataManager())
    var updateLabels: UpdateLabels?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initSupportedList(uiTableView: tableView)
    }

    // MARK: - Outlets

    @IBOutlet weak var modalSearchBar: UISearchBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var modalHeadView: UIView! {
        didSet {
            modalHeadView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Actions

    @IBAction func onPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ExchangeModalViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.supportedListSearch = viewModel.filterSearchbarList(list: (viewModel.supportedList)!, searchText: searchText )
        tableView.reloadData()
    }

    // Disable keyboard on Press Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension ExchangeModalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.supportedListSearch!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = viewModel.supportedListSearch![indexPath.row].currencyName
        cell.detailTextLabel?.text = viewModel.supportedListSearch![indexPath.row].currencyCode
        // Dismiss keyboard on Drag
        tableView.keyboardDismissMode = .onDrag
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.supportedListSearch![indexPath.row].currencyCode
        viewModel.addSelectedItem(uiTableView: tableView, selectedItem: selectedItem, selected: selected!, delegate: updateLabels)
        self.dismiss(animated: true, completion: nil)
    }

}
