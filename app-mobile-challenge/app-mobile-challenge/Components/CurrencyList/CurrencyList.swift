//
//  CurrencyList.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Protocols

protocol CurrencyListService: AnyObject {
    func choiced(list: List)
}

// Class

final class CurrencyList: UITableView {

    // Properties

    weak var cdelegate: CurrencyListService?

    // Private Properties

    private var lists: Lists { CommonData.shared.lists }
    private lazy var viewModel =
        CurrencyListViewModel(lists: lists)

    // Lifecycle

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private Methods

    private func setup() {
        self.delegate = self
        self.dataSource = self
        style()
        setUpViews()
    }

    private func setUpViews() {
        register()
        inicializeFavorites()
    }

    private func style() {
        separatorStyle = .none
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        sectionHeaderHeight = 42
        backgroundColor = DesignSystem.Colors.background
        allowsSelection = true
    }

    private func register() {
        register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.self.description())
    }

    private func toggle(indexPath: IndexPath) {
        viewModel.toggleFavorite(indexPath: indexPath)
        reloadData()
    }

    private func selected(indexPath: IndexPath) {
        let list = viewModel.elementBy(indexPath: indexPath)
        cdelegate?.choiced(list: list)
    }

    public func filterBy(textSearched: String) {
        viewModel.filterBy(textSearched: textSearched)
        reloadData()
    }

    private func inicializeFavorites() {
        viewModel.inicializeFavorites()
        reloadData()
    }
}

// Delegates

extension CurrencyList: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elementsBy(section: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: CurrencyListCell.self.description(), for: indexPath) as? CurrencyListCell else {
            return UITableViewCell()
        }
        let lists = viewModel.elementsBy(section: indexPath.section)
        cell.setup(currency: lists[indexPath.row], indexPath: indexPath)
        cell.toggleAction = toggle
        cell.selectedAction = selected

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignSystem.Height.tableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.title(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = DesignSystem.Colors.background
            headerView.textLabel?.font = TextStyle.display3.font
            headerView.textLabel?.textColor = DesignSystem.Colors.secondary
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = DesignSystem.Colors.background
        return view
    }
}
