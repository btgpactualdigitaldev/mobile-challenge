//
//  CurrenciesView.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 15/07/22.
//

import UIKit

protocol CurrenciesViewDelegate: AnyObject {
    func didSelectCurrency(currency: String)
}
class CurrenciesView: UIView {
    
    var viewModel: CurrenciesViewModelProtocol?
    let cellIdentifer = "cell"
    weak var delegate: CurrenciesViewDelegate?
    
    init(frame: CGRect = .zero, viewModel: CurrenciesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.viewModel?.currenciesDelegate = self
        setupView()
        indicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        return tableView
    }()
    
}

extension CurrenciesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currenciesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as? CurrencyListTableViewCell,
              let currencyName = viewModel?.getCurrencyName(index: indexPath.row),
              let currencyInitials = viewModel?.getCurrencyInitials(index: indexPath.row)
        else { return UITableViewCell() }
    
        cell.setupCell(currencieName: currencyInitials + " - " + currencyName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCurrency(currency: "USD" + (viewModel?.getCurrencyInitials(index: indexPath.row) ?? ""))
    }
}

extension CurrenciesView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(indicatorView)
    }
    
    func setupConstraints() {
        tableView.anchorTo(superview: self)
        indicatorView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
    }
}

extension CurrenciesView: CurrenciesViewModelDelegate {
    func didFetchCurrencies() {
        indicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }

    func didFailToFetchCurrencies() {
        print("fail to fetch currencies")
    }
}
