//
//  SelectionViewControllerTableViewController.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

private let reuseIdentifer = "SelectionViewCell"

class SelectionViewController: UITableViewController,  UISearchBarDelegate  {
  
  // MARK: - Init
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private var viewModel : MainViewModel?
  private let searchBar = UISearchBar()
  private var sortItem : UIBarButtonItem?
  private var filterItems = [] as [CurrencyEntity]
  private var currencyList = [] as [CurrencyEntity]
  var type = ""
  var code = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    viewModel = appDelegate.mainViewModel
    configureNavigationBar()
    self.clearsSelectionOnViewWillAppear = false
    self.tableView.separatorStyle = .none
    self.tableView.rowHeight = 60
    self.tableView.register(SelectionViewCell.self, forCellReuseIdentifier: reuseIdentifer)
    currencyList = viewModel!.currencyList.sorted(by: { (first, second) -> Bool in
      first.currencyCode < second.currencyCode
    })
    filterItems = currencyList
    self.tableView.reloadData()
    let position = filterItems.firstIndex { (currency) -> Bool in
      currency.currencyCode == code
    }
    scrollToBottom(position: position ?? 0)
  }
  
  
  // MARK: - Configure NavigationBar
  
  func configureNavigationBar() {
    self.searchBar.sizeToFit()
    self.searchBar.delegate = self
    self.searchBar.searchTextField.backgroundColor = .white
    self.searchBar.searchTextField.textColor = UIColor(named: "app_dark")
    self.searchBar.searchTextField.tintColor = UIColor(named: "app_dark")
    self.searchBar.keyboardAppearance = .light
    self.searchBar.setImage(UIImage(systemName: "magnifyingglass" ), for: .search, state: .normal)
    self.searchBar.tintColor = .white
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
    sortItem = UIBarButtonItem(image: UIImage(named: "ic_sort"), style: .plain, target: self, action: #selector(handleSortToggle(_ :)))
    sortItem!.tintColor = .white
    showSearchButton(shouldShow: true)
  }
  
  // MARK: - Configure Sort
  
  @objc func handleSortToggle(_ sender : UIBarButtonItem) {
    self.view.endEditing(true)
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Sort by Code", style: .default , handler:{ (UIAlertAction)in
      self.filterItems = self.viewModel!.currencyList.sorted(by: { (first, second) -> Bool in
        first.currencyCode < second.currencyCode
      })
      self.tableView.reloadData()
      self.scrollToBottom(position: 0)
    }))
    alert.addAction(UIAlertAction(title: "Sort by Name", style: .default , handler:{ (UIAlertAction)in
      self.filterItems = self.viewModel!.currencyList.sorted(by: { (first, second) -> Bool in
        first.currencyName < second.currencyName
      })
      self.tableView.reloadData()
      self.scrollToBottom(position: 0)
    }))
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    alert.pruneNegativeWidthConstraints()
    alert.popoverPresentationController?.sourceView = self.view
    alert.popoverPresentationController?.barButtonItem = sender
    self.present(alert, animated: true)
  }
  
  // MARK: - Configure SearchBar
  
  func showSearchButton(shouldShow: Bool){
    if shouldShow {
      self.navigationItem.titleView = nil
      self.searchBar.searchTextField.text = " "
      self.searchBar.searchTextField.text = ""
      let itemRight = UIBarButtonItem(barButtonSystemItem: .search,
                                      target: self,
                                      action: #selector(handleShowSearchBar))
      if let sort = sortItem {
        self.navigationItem.rightBarButtonItems = [sort,itemRight]
      } else {
        self.navigationItem.rightBarButtonItem = itemRight
      }
      searchBar.showsCancelButton = false
    } else {
      self.navigationItem.titleView = searchBar
      self.searchBar.showsCancelButton = true
      self.navigationItem.rightBarButtonItems = nil
      self.searchBar.becomeFirstResponder()
    }
  }
  
  @objc func handleShowSearchBar() {
    showSearchButton(shouldShow: false)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    showSearchButton(shouldShow: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.endEditing(true)
    filterItems = currencyList
    self.tableView.reloadData()
  }
  
  // MARK: SearchBar filter
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text!.count > 1 {
      let filter = currencyList.filter { (currency) -> Bool in
        currency.currencyCode.lowercased().contains(String(searchBar.text!).lowercased()) ||
          currency.currencyName.lowercased().contains(String(searchBar.text!).lowercased())
      }
      if filter != filterItems {
        filterItems = filter
        self.tableView.reloadData()
      }
    } else {
      filterItems = currencyList
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterItems.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer) as! SelectionViewCell
    let item = filterItems[indexPath.row]
    cell.titleLabel.text = "\(item.currencyCode) - \(item.currencyName)"
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = filterItems[indexPath.row]
    if (type == "FROM") {
      viewModel?.setQuoteValue(
        code: item.currencyCode,
        type: "FROM"
      )
    } else {
      viewModel?.setQuoteValue(
        code: item.currencyCode,
        type: "TO"
      )
    }
    view.endEditing(true)
    self.navigationController?.popViewController(animated: true)
  }
  
  func scrollToBottom(position: Int){
    Dispatch.main {
      if (self.tableView.numberOfRows(inSection: 0) > 0){
        let indexPath = IndexPath( row: position, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
      }
    }
  }
  
}
