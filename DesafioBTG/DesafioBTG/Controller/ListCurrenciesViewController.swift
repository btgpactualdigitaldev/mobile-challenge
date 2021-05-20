//
//  ListCurrenciesViewController.swift
//  DesafioBTG
//
//  Created by Any Ambria on 12/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import UIKit

class ListCurrenciesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var errorView: UIView?
    
    var viewModel: CurrenciesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CurrenciesViewModel(currenciesProvider: CurrenciesProvider(), viewController: self)
        bindElements()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchListCurrencies()
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        viewModel?.fetchListCurrencies()
    }
    
    func bindElements() {
        tableView?.dataSource = self
        tableView?.delegate = self
        
        self.tableView?.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
        
        viewModel?.errorList.bind(skip: true, { [weak self] (errored) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if errored  {
                    self.errorView?.isHidden = false
                    self.tableView?.isHidden = true
                } else {
                    self.errorView?.isHidden = true
                    self.tableView?.isHidden = false
                    self.tableView?.reloadData()
                }
            }
        })
    }
}

extension ListCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseId, for: indexPath) as? CurrencyTableViewCell ?? CurrencyTableViewCell()
        
        let name = viewModel?.currencies[indexPath.row].1 ?? ""
        let code = viewModel?.currencies[indexPath.row].0 ?? ""
        
        cell.setup(name: name, code: code)
        return cell
    }
    
    
}
