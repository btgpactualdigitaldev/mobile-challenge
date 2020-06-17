//
//  CurrencyTableViewController.swift
//  BTGPactualTest
//
//  Created by Vinicius Custodio on 16/06/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation
import UIKit

class CurrencyTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    
    var currencies = [Currency]()
    var selectCallback: ((Currency) -> Void)?
    var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Moedas"
        self.currencies = CurrencyConverter.manager.currencies!
    }
    
    var selectedCurrency: Currency?
}

extension CurrencyTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as? CurrencyCell else {
            return UITableViewCell()
        }
    
        let currency = currencies[indexPath.row]
        cell.setup(code: currency.code, name: currency.name, selected: selectedCurrency?.code == currency.code)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        
        self.selectCallback?(currency)
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension CurrencyTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.isEmpty || updatedText == "\n" {
                self.currencies = CurrencyConverter.manager.currencies!
            
            } else {
                self.currencies = CurrencyConverter.manager.currencies!.filter({ (currency) -> Bool in
                    return currency.filter.contains(updatedText.uppercased())
                })
            }
            
            self.tableView.reloadData()
        }
        
        return true
    }
}

