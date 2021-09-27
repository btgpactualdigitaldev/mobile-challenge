//
//  CurrencyListController.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import UIKit

protocol SelectCurrencyDelegate : AnyObject {
    func selected(currency: Currency)
}

class CurrencyListController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tblCurrencies: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    // MARK: - Delegate
    
    weak var delegate: SelectCurrencyDelegate?
    
    // MARK: - Public properties
    
    var coordinator: Coordinator?
    var viewModel: CurrencyListViewModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.list()
    }
    
    deinit {
        unbind()
    }

    // MARK: - IBActions
    
    @IBAction func didChangeSearchText(_ sender: Any) {
        viewModel?.search(for: txtSearch.text)
    }

}

// MARK: - Binding extension

extension CurrencyListController {
    
    private func bind() {
        NotificationCenter.default.addObserver(self, selector: #selector(showCurrencyList(_:)), name: NSNotification.Name(Constants.CurrencyListNotificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showListCurrencyError(_:)), name: NSNotification.Name(Constants.CurrencyListErrorNotificationName.rawValue), object: nil)
    }
    
    private func unbind() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Constants.CurrencyListNotificationName.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Constants.CurrencyListErrorNotificationName.rawValue), object: nil)
    }
    
    @objc private func showCurrencyList(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tblCurrencies.reloadData()
        }
    }
    
    @objc private func showListCurrencyError(_ notification: Notification) {
        guard let error = notification.object as? Error else { return }
        print(error)
    }
}

// MARK: - UITableViewDataSource

extension CurrencyListController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currencyList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier) as? CurrencyCell, let currency = viewModel?.currencyList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setup(with: currency)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CurrencyListController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCurrency = viewModel?.currencyList?[indexPath.row] else { return }
        delegate?.selected(currency: selectedCurrency)
        coordinator?.back()
    }
    
}
