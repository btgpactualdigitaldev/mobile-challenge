//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import UIKit

class CurrencyListView: BaseView {
    
    // MARK: - UI Components
    
    lazy var titleLabel = TitleLabel()
        .set(\.text, to: "Select a currency")
    
    lazy var cancelButton = UIButton(type: .system)
        .run {
            $0.setTitle(LocalizableStrings.generalCancelText.localized, for: .normal)
        }
    
    lazy var searchBar = UISearchBar()
    
    lazy var currenciesTableView = UITableView(frame: .zero, style: .grouped)
        .set(\.backgroundColor, to: .white)
        .set(\.contentInset, to: UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0))
        .set(\.tableFooterView, to: UIView())
        .run {
            $0.register(CurrencyTableViewCell.self)
        }
    
    // MARK: - Setup
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(cancelButton)
        addSubview(searchBar)
        addSubview(currenciesTableView)
    }
    
    override func autoLayout() {
        titleLabel
            .anchor(top: safeAreaLayoutGuide.topAnchor, padding: 24)
            .anchor(centerX: centerXAnchor)
    
        cancelButton
            .anchor(centerY: titleLabel.centerYAnchor)
            .anchor(left: leftAnchor, padding: 16)
        
        searchBar
            .anchor(top: titleLabel.bottomAnchor, padding: 24)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
        
        currenciesTableView
            .anchor(top: searchBar.bottomAnchor)
            .anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
            .anchor(leading: leadingAnchor)
            .anchor(trailing: trailingAnchor)
    }
    
}
