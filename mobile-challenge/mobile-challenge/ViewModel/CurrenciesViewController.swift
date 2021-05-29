//
//  CurrenciesViewController.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 24/11/20.
//

import UIKit

class CurrenciesViewController: UIViewController {

    ///Constant of the link that gets the requests
    let url = "http://api.currencylayer.com/list?access_key=baa8ca67a82137316bb59b665428e101"
    
    ///Dictionary that will store the values of the currencies fetched from API
    var quotes: Dictionary<String, String> = [:]
    ///Array that will store the values of the acronyms of the currencies
    var acronyms: [String] = []
    ///Array that will store the names of the currencies
    var currencyNames: [String] = []
    ///Amount of the cells
    var count = 0
    /// Will store the acronym of the selected cell
    var selected = " "
    /// Instace of the Pass Currency Delegate
    var passCurrency: PassCurrencyDelegate?
    ///Will store the index path of the selected cell
    var indexPath = 0
    ///Instance of view controller to change the title of the button
    var viewControllerInstance = ViewController()
    ///Flag to verify which button is the sender
    var flag = 0
    
    ///Outlet of the table view
    @IBOutlet weak var currencyTableView: UITableView!
    
    ///Sets the tableview delegate and datasource, sets the count of cells the tableview will need
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        count = acronyms.count
    
    }
    
    ///Function that will dismiss the view
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    ///Function that will pass the selected acronym and the flag back to the main view controller and dismiss the view
    @IBAction func saveButton(_ sender: Any) {
        self.selected = acronyms[indexPath]
        if flag == 1{
            self.passCurrency?.passCurrency(currency: selected,flag: 1)
        }else if flag == 2{
            self.passCurrency?.passCurrency(currency: selected,flag: 2)
            
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyCell
        cell.currencyLabel.text =
            self.acronyms[indexPath.row] + " - " + self.currencyNames[indexPath.row]
        if cell.isSelected{
            currencyTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            self.selected = self.acronyms[indexPath.row]
            self.indexPath = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
    }
}


