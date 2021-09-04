//
//  CoinListView.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class CoinListView: UIView {
    var bs: NSLayoutConstraint?
    
    weak var visualDelegate: VisualInputDelegate? {
        didSet { tableHeader.visualDelegate = visualDelegate } }
    
    // MARK: View
    let tableHeader = CoinTableHeader()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100*Helper.wr()
        tableView.register(cellType: CoinTableCell.self)
        //tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0,
                                                         width: 0.1, height: Constants.space))
        return tableView
    }()
    
    let emptyList: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = UIFont(name: "Moderat-Bold", size: 22)
        label.isHidden = true
        label.numberOfLines = 0
        label.text = L10n.Coin.List.emptyList
        label.textAlignment = .center
        label.textColor = Asset.Colors.gray.color
        return label
    }()
    
    let emptySearch: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = UIFont(name: "Moderat-Bold", size: 22)
        label.isHidden = true
        label.numberOfLines = 0
        label.text = L10n.Coin.List.emptySearch
        label.textAlignment = .center
        label.textColor = Asset.Colors.gray.color
        return label
    }()
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Animation
    func showView(_ view: UIView) {
        if view == emptySearch && !emptyList.isHidden { return }
        
        view.isHidden = false
        //view.alpha = 0
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            view.alpha = 1
        })
    }
    
    func hideView(_ view: UIView) {
        //view.isHidden = false
        //view.alpha = 1
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            view.alpha = 0
        }, completion: {_ in view.isHidden = true})
    }
    
    // MARK: Keyboard
    func showKeyboard(with height: CGFloat) {
        bs?.constant = -height
        
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func hideKeyboard() {
        bs?.constant = 0
        
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            self.layoutIfNeeded()
        })
    }
}

private extension CoinListView {
    // MARK: Setup
    func setup() {
        backgroundColor = Asset.Colors.background.color
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTouch))
        addGestureRecognizer(tap)
        
        addSubview(tableView)
        tableView.top(equalTo: self)
        tableView.fillHorizontal(to: self)
        bs = tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        bs?.isActive = true
        
        addSubview(emptyList)
        emptyList.centerY(equalTo: self, constant: -58-Helper.safeSize(for: .bottom))
        emptyList.fillHorizontal(to: self, constant: Constants.space*2)
        
        addSubview(emptySearch)
        emptySearch.centerY(equalTo: self, constant: -58-Helper.safeSize(for: .bottom))
        emptySearch.fillHorizontal(to: self, constant: Constants.space*2)
    }
    
    @objc
    func didTouch() {
        tableHeader.searchField.resignFirstResponder()
    }
}
