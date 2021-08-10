//
//  CurrenciesAvaliableViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

protocol ConversionDelegate {
	func getFromCurrency(selectedCurrencyCode: String)
	func getToCurrency(selectedCurrencyCode: String)
}

enum FillingField {
	case fromCurrency
	case toCurrency
}

class AvaliableCurrenciesViewController: BTGViewController {
	private let viewModel = ConversionViewModel()
	private var currenciesView: AvaliableCurrenciesView { return self.view as! AvaliableCurrenciesView }
	private var avaliableQuotes = [(code: String, description: String)]()
	private var fillingField: FillingField?
	private var searchQuotes = [(code: String, description: String)]()
	private var isSearching: Bool = false
	
	var delegate: ConversionDelegate?
	
	init(filling: FillingField) {
		super.init(nibName: nil, bundle: nil)
		self.fillingField = filling
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindUI()
		navigationItem.titleView = currenciesView.getSearchToTitle()
	}
	
	override func loadView() {
		self.view = AvaliableCurrenciesView(frame: UIScreen.main.bounds)
		currenciesView.tableViewDelegate = self
		currenciesView.tableViewDataSource = self
		currenciesView.searchBarDelegate = self
	}

	private func bindUI() {
		self.showLoading()
		viewModel.getAvaliableQuotes { [weak self] result in
			guard let self = self else { return }
			self.hideLoading()
			switch result {
			case .success(let avaliableQuotes):
				self.avaliableQuotes = avaliableQuotes
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.currenciesView.reloadTableData()
				}
				
			case .failure(let error):
				self.handlerError(error) {
					self.navigationController?.popViewController(animated: true)
				}
			}
		}
	}
}

// MARK: TableBiew setup
extension AvaliableCurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return isSearching ? searchQuotes.count : avaliableQuotes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AvaliableCurrencyTableViewCell.identifier, for: indexPath) as? AvaliableCurrencyTableViewCell else {
			return UITableViewCell()
		}
		
		if isSearching {
			cell.config(code: searchQuotes[indexPath.row].code, description: searchQuotes[indexPath.row].description)
		} else {
			cell.config(code: avaliableQuotes[indexPath.row].code, description: avaliableQuotes[indexPath.row].description)
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let quotes = isSearching ? searchQuotes : avaliableQuotes
		self.navigationController?.popViewController(animated: true)
		fillingField == .fromCurrency ?
			delegate?.getFromCurrency(selectedCurrencyCode: quotes[indexPath.row].code) :
			delegate?.getToCurrency(selectedCurrencyCode: quotes[indexPath.row].code)
	}
}

// MARK: Search setup
extension AvaliableCurrenciesViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		searchQuotes = avaliableQuotes.filter {
			$0.description.prefix(searchText.count).lowercased() == searchText.lowercased() ||
		    $0.code.prefix(searchText.count).lowercased() == searchText.lowercased().lowercased() }
		
		isSearching = true
		currenciesView.reloadTableData()
	}
}
