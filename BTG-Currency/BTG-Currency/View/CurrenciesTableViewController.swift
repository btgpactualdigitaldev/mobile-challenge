//
//  CurrenciesTableViewController.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 29/10/21.
//

import UIKit
import Combine

class CurrenciesTableViewController: UITableViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Attributes
    private var isConnected: Bool = true
    private var dataSource: [ListItem] = []
    private var viewModel: CurrenciesViewModel!
    
    //MARK: - Combine attributes
    private var cancellables = Set<AnyCancellable>()
    private var filterSubject = PassthroughSubject<String, Never>()
    var filterPublisher: AnyPublisher<String, Never> {
        filterSubject.eraseToAnyPublisher()
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Container.shared.resolve(CurrenciesViewModel.self)
        binding()
        
        title = "Currencies"
        navigationController?.navigationBar.prefersLargeTitles = true
        let sortByNameButton = UIBarButtonItem(title: "Name", style: .plain, target: self, action: #selector(sortByName))
        let sortByCodeButton = UIBarButtonItem(title: "Code", style: .plain, target: self, action: #selector(sortByCode))
        navigationController?.navigationBar.topItem?.rightBarButtonItems = [sortByCodeButton, sortByNameButton]
        
        searchBar.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataSource.isEmpty && self.isConnected {
            viewModel.fetchList()
        }
    }

    // MARK: - Data Source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isConnected else { return 1 }
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard isConnected else {
            return tableView.dequeueReusableCell(NoInternetTableViewCell.self)
        }
        
        let item = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(ListItemTableViewCell.self)
        cell.setup(code: item.code, countryName: item.countryName)
        return cell
    }
    
    //MARK: - Delegate methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}

//MARK: - Sort methods
extension CurrenciesTableViewController {
    @objc private func sortByName() {
        viewModel.sortByName()
    }
    
    @objc private func sortByCode() {
        viewModel.sortByCode()
    }
}

//MARK: - Binding methods
extension CurrenciesTableViewController {
    private func binding() {
        cancellables = [
            viewModel.connectivityPublisher
                .receive(on: DispatchQueue.main)
                .debounce(for: .seconds(1), scheduler: DispatchQueue(label: "CurrenciesTableViewController"))
                .sink(receiveValue: { [weak self] isConnected in
                    let isConnectedPrevious = self?.isConnected ?? false
                    let isConnectedNew = isConnected
                    let isDataSourceEmpty = self?.dataSource.isEmpty ?? true
                    let shouldFetch = !isConnectedPrevious && isConnectedNew && isDataSourceEmpty

                    self?.isConnected = isConnected
                    
                    if shouldFetch {
                        self?.viewModel.fetchList()
                    } else {
                        DispatchQueue.main.async {
                            self?.tableView.reloadData(animated: false)
                        }
                    }
                }),
            viewModel.listPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] result in
                    switch result {
                    case .success(let list):
                        self?.dataSource = list
                        self?.tableView.reloadData(animated: false)
                    case .failure(let error):
                        let exceptionVC = ExceptionViewController.instantiated()
                        exceptionVC.error = error
                        self?.navigationController?.pushViewController(exceptionVC, animated: true)
                    }
                })
        ]
        viewModel.attachFilterListener(filterPublisher)
    }
}

//MARK: - UISearchBarDelegate methods
extension CurrenciesTableViewController: UISearchBarDelegate {
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        self.view.frame.origin.y = -keyboardSize.height + 40
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc private func dismissKeyboard(_ gesture: UIGestureRecognizer) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSubject.send(searchText)
    }
}
