//
//  AvaliableCurrenciesView.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class AvaliableCurrenciesView: UIView {
	private let tableView = UITableView()
	private let searchBar = UISearchBar()
	
	public var tableViewDataSource: UITableViewDataSource? {
		willSet(newValue) {
			tableView.dataSource = newValue
		}
	}
	public var tableViewDelegate: UITableViewDelegate? {
		willSet(newValue) {
			tableView.delegate = newValue
		}
	}
	public var searchBarDelegate: UISearchBarDelegate? {
		willSet(newValue) {
			searchBar.delegate = newValue
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(tableView)
		backgroundColor = .white
		searchBar.placeholder = AppStrings.shared.choiceCurrencySearchPlaceholder
		tableView.register(AvaliableCurrencyTableViewCell.self, forCellReuseIdentifier: AvaliableCurrencyTableViewCell.identifier)
		setupConstraints()
	}
	
	private func setupConstraints() {
		let top: NSLayoutYAxisAnchor
		let bottom: NSLayoutYAxisAnchor
		
		if #available(iOS 11.0, *) {
			top = safeAreaLayoutGuide.topAnchor
			bottom = safeAreaLayoutGuide.bottomAnchor
		} else {
			top = topAnchor
			bottom = bottomAnchor
		}
		
		tableView.anchor(
			top: (top, 0),
			right: (rightAnchor, 0),
			left: (leftAnchor, 0),
			bottom: (bottom, 0)
		)
	}
	
	public func reloadTableData() {
		tableView.reloadData()
	}
	
	public func getSearchToTitle() -> UISearchBar {
		return searchBar
	}
}
