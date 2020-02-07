//
//  CurrencyListTableViewController.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import UIKit

class CurrencyListTableViewController: UITableViewController {
    
    var viewModel: ListOfCurrencyViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        requestCurrencyList()
    }
        
    func initialize() {
        let repository = ListCurrencyRepository()
        viewModel = ListOfCurrencyViewModel(listCurrencyRepository: repository, presentErrorDelegate: self)
        tableView.register(UINib(nibName: "CurrencyCellTableViewCell", bundle: .main), forCellReuseIdentifier: "CurrencyCellTableViewCell")
    }
    
    func requestCurrencyList() {
        self.viewModel.requestCurrencyList {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalOfCurrencies()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCellTableViewCell", for: indexPath) as! CurrencyCellTableViewCell
        cell.setCellContent(code: viewModel.currencyList[indexPath.row].key, description: viewModel.currencyList[indexPath.row].value)

        return cell
    }
    
}

extension CurrencyListTableViewController: PresentErrorDelegate {
    func present(error: String) {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title:"Erro", message: error, preferredStyle:.alert)
            let okAction = UIAlertAction(title:"Ok, entendi.", style: .cancel)
            let tryAgainAction = UIAlertAction(title: "Tentar Novamente", style: .default, handler: {[weak self]
                _ in
                self?.requestCurrencyList()
            })
            alertController.addAction(okAction)
            alertController.addAction(tryAgainAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
