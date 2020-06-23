//
//  CurrencyListTableTableViewController.swift
//  coin.verter
//
//  Created by Caio Berkley on 23/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import UIKit

class CurrencyListTableTableViewController: UIViewController {
    
    //MARK - Variables
    var sortedOption: Bool = false
    var controller : CurrencyController?
    var selectedCurrency: String?
    
    //MARK - Closures
    var didSelectValue: (String) -> Void = { _ in }
    
    //MARK - Outlets
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var currencySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = CurrencyController()
        self.controller?.delegate = self
        
        self.controller?.setupCurrencyListViewController()
        
        self.currencyTableView.delegate = self
        self.currencyTableView.dataSource = self
        
        self.currencySearchBar.delegate = self
        
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        
        self.sortedOption = !self.sortedOption
        
        self.controller?.sortArray(for: self.sortedOption)
        
        self.currencyTableView.reloadData()
        
    }
}

extension CurrencyListTableTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.controller?.getNumberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        cell.textLabel?.text = self.controller?.loadCurrencyWithIndexPath(with: indexPath).key
        cell.detailTextLabel?.text = self.controller?.loadCurrencyWithIndexPath(with: indexPath).value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellValue = self.controller?.loadCurrencyWithIndexPath(with: indexPath).key else { return }
        
        didSelectValue(cellValue)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension CurrencyListTableTableViewController : UISearchBarDelegate {
    
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

extension CurrencyListTableTableViewController : CurrencyControllerDelegate {
    
    func successOnLoadingListOfCurrencies() {
        
        DispatchQueue.main.async {
            
            self.currencyTableView.reloadData()
            
        }
    }
    
    func errorOnLoadingListOfCurrencies(error: CurrencyError) {
        
        if !error.localizedDescription.isEmpty {
            
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "Erro", message: "Problema ao carregar os dados das moedas", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alert.addAction(okButton)
                
                self.present(alert, animated: true)
            }
        }
    }
    
    func timeToStopActivity(resp: Bool) {
        
        if resp {
            DispatchQueue.main.async {
                
                self.currencyTableView.reloadData()
        
            }
        } else {
            
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "Erro", message: "Problema ao carregar os dados dos moedas", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alert.addAction(btnOk)
                
                self.present(alert, animated: true)
                
            }
        }
    }
}
