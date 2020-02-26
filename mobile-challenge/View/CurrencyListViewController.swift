//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Alan Silva on 11/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CurrencyListViewController: BaseViewController {
    
    var sortedOption: Bool = false
    var controller : CurrencyController?
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var currencySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.startActivityIndicator()
        currencySearchBar.searchTextField.backgroundColor = .white
        currencySearchBar.placeholder = "Busque por nome ou codigo"
        
        self.controller = CurrencyController()
        self.controller?.delegate = self
        
        self.controller?.setupCurrencyListViewController()
        
        //delegate and datasource TableView
        self.currencyTableView.delegate = self
        self.currencyTableView.dataSource = self
        
        //delegate and datasource SearchBar
        self.currencySearchBar.delegate = self
        
    }
    
    @IBAction func btnSortCurrencies(_ sender: UIButton) {
        
        self.sortedOption = !self.sortedOption
        
        self.controller?.sortArray(for: self.sortedOption)
        
        self.currencyTableView.reloadData()
        
    }
    
}

//MARK: - EXTENSION OF UITableViewDelegate AND UITableViewDataSource

extension CurrencyListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.controller?.getNumberOfRowsInSection() ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        cell.textLabel?.text = self.controller?.loadCurrencyWithIndexPath(with: indexPath).value
        cell.detailTextLabel?.text = self.controller?.loadCurrencyWithIndexPath(with: indexPath).key
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

//MARK: - EXTENSION OF UISearchBarDelegate

extension CurrencyListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.controller?.updateArray()
                self.currencyTableView.reloadData()
            }
            
        }
        else {
            
            self.controller?.searchByValue(searchText: searchText)
            
            self.currencyTableView.reloadData()
        }
        
    }
    
}

//MARK: - EXTENSION OF CurrencyControllerDelegate

extension CurrencyListViewController : CurrencyControllerDelegate {
    
    func successOnLoadingListOfCurrencies() {
        
        DispatchQueue.main.async {
            
            self.currencyTableView.reloadData()
            self.stopActivityIndicator()
            
        }
        
    }
    
    func errorOnLoadingListOfCurrencies(error: CurrencyError) {
        
        if !error.localizedDescription.isEmpty {
            
            DispatchQueue.main.async {
                
                let alerta = UIAlertController(title: "Erro", message: "Problema ao carregar os dados das moedas", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alerta.addAction(btnOk)
                
                self.present(alerta, animated: true)
                
            }
            
        }
        
    }
    
    func timeToStopActivity(resp: Bool) {
        
        
        if resp {
            
            DispatchQueue.main.async {
                
                self.currencyTableView.reloadData()
                self.stopActivityIndicator()
                
            }
            
        }
        else {
            
            DispatchQueue.main.async {
                
                let alerta = UIAlertController(title: "Erro", message: "Problema ao carregar os dados dos moedas", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alerta.addAction(btnOk)
                
                self.present(alerta, animated: true)
                
                self.stopActivityIndicator()
            }
            
        }
        
    }
    
}
