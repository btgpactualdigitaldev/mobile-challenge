//
//  CurrencyListViewController.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 03/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import Foundation
import UIKit

class CurrencyListViewController: UIViewController {
    //MARK: Attributes
    let filterTextField: UISearchTextField = {
        let lb = UISearchTextField()
        lb.placeholder = "Pesquise.."
        lb.autocorrectionType = .no
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let currencyListTableView: UITableView = {
        let tv = UITableView()
        tv.register(CurrencyViewCell.self, forCellReuseIdentifier: CurrencyViewCell.identifier)
        tv.register(EmptyCurrencyViewCell.self, forCellReuseIdentifier: EmptyCurrencyViewCell.identifier)
        tv.isHidden = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let selectButton: CurrencyButton = {
        let bt = CurrencyButton(title: "Selecione")
        bt.disable()
        return bt
    }()
    
    let viewModel: CurrencyListViewModel
    let delegate: CurrencyExchangeViewControllerDelegate
    
    //MARK: View LifeCycle
    init(_ viewModel: CurrencyListViewModel, delegate: CurrencyExchangeViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Lista de moedas"
        
        setupConstraints()
        setupDelegatesAndButtonTargets()
        hideKeyboardWhenTappedAround()
        
        getCurrencies()
    }
    
    //MARK: Functions
    fileprivate func setupConstraints() {
        self.view.addSubview(filterTextField)
        self.view.addSubview(currencyListTableView)
        self.view.addSubview(selectButton)
        
        filterTextField.topAnchor.anchor(self.view.topAnchor, 20)
        filterTextField.leftAnchor.anchor(self.view.leftAnchor, 20)
        filterTextField.rightAnchor.anchor(self.view.rightAnchor, -20)
        
        currencyListTableView.topAnchor.anchor(filterTextField.bottomAnchor, 20)
        currencyListTableView.leftAnchor.anchor(self.view.leftAnchor)
        currencyListTableView.rightAnchor.anchor(self.view.rightAnchor)
        currencyListTableView.bottomAnchor.anchor(selectButton.topAnchor, -20)
        
        selectButton.leftAnchor.anchor(self.view.leftAnchor, 20)
        selectButton.rightAnchor.anchor(self.view.rightAnchor, -20)
        selectButton.bottomAnchor.anchor(self.view.bottomAnchor, -20)
    }
    
    fileprivate func setupDelegatesAndButtonTargets() {
        self.filterTextField.delegate = self
        self.currencyListTableView.delegate = self
        self.currencyListTableView.dataSource = self
        
        self.selectButton.addTarget(self, action: #selector(selectCurrency), for: .touchUpInside)
    }
    
    fileprivate func getCurrencies() {
        showLoading {
            self.viewModel.getCurrencies { [weak self] error in
                guard let wSelf = self else { return }
                wSelf.dismissLoading()
                
                if let error = error {
                    wSelf.showError(error)
                }
                
                DispatchQueue.main.async {
                    wSelf.currencyListTableView.isHidden = false
                    wSelf.currencyListTableView.reloadData()
                }
            }
        }
    }
    
    @objc fileprivate func selectCurrency() {
        guard let currency = viewModel.selectedCurrency else { return }
        self.delegate.didSelectCurrency(currency, button: viewModel.selectedButton)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: Extensions
extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.filteredCurrencies.isEmpty {
            return 1
        }
        return viewModel.filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.filteredCurrencies.isEmpty {
            return self.currencyListTableView.frame.height
        }
        return CurrencyViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.filteredCurrencies.isEmpty {
            return EmptyCurrencyViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyViewCell.identifier) as? CurrencyViewCell else {
            return UITableViewCell()
        }
        
        let currency = self.viewModel.filteredCurrencies[indexPath.row]
        cell.setup(currency: currency.initials, name: currency.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectCurrency(self.viewModel.filteredCurrencies[indexPath.row])
        self.selectButton.enable()
    }
}

extension CurrencyListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var finalString = "\(textField.text!)\(string)"
        
        if string == "" {
            finalString.removeLast()
        }
        
        if finalString == "" {
            self.viewModel.filteredCurrencies = self.viewModel.currencies
            self.currencyListTableView.reloadData()
            return true
        }
        
        self.viewModel.filteredCurrencies = self.viewModel.currencies.filter({ $0.name.lowercased().contains(finalString.lowercased()) || $0.initials.lowercased().contains(finalString.lowercased()) })
        self.currencyListTableView.reloadData()
        
        return true
    }
}
