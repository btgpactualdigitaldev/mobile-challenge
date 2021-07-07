//
//  CurrencyListViewController.swift
//  Currency Converter
//
//  Created by Otávio Souza on 28/09/20.
//

import UIKit

protocol CurrencyListViewControllerDelegate {
    func setCurrency(value: String,abreviation: String, type: CurrencyType)
}

class CurrencyListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currencyType: CurrencyType = .from
    var delegate:CurrencyListViewControllerDelegate!
    
    var currencyListViewModel = CurrencyListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencies()
        setup()
    }
    
    func setup() {
        searchBar.delegate = self
        tableView.delegate = self
    }
    
    @IBAction func changed(_ sender: Any) {
        print(segmentedControl.selectedSegmentIndex)
        if segmentedControl.selectedSegmentIndex == 1 {
            currencyListViewModel.sortByCode()
        } else {
            currencyListViewModel.sortByText()
        }
        if let text = searchBar.text, !text.isEmpty {
            search(forText: text)
        }
        tableView.reloadData()
    }
    
    func getCurrencies() {
        currencyListViewModel.fetchCurrencies{ [weak self] currencies in
            DispatchQueue.main.async { [self] in
                switch currencies{
                case .failure(let error):
                    if let showFromBackup = self?.currencyListViewModel.loadFromBackup()  {
                        if showFromBackup {
                            self?.updateUI()
                            self?.show(error: "Loaded from backup")
                            return
                        }
                    }
                    
                    if let error2 = error as? CustomError {
                        self?.show(error: error2.info)
                    } else {
                        self?.show(error: error.localizedDescription)
                    }
                case .success(_):
                    self?.updateUI()
                }
            }
        }
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default)
        { action -> Void in
            self.getCurrencies()
        })
        self.present(alert, animated: true)
    }
    
    func updateUI() {
        tableView.reloadData()
    }

}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyListViewModel.currenciesSorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyListViewCell
        let currency = currencyListViewModel.currenciesSorted[indexPath.row]
        cell.abbreviation.text = currency.key
        cell.name.text = currency.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencyListViewModel.currenciesSorted[indexPath.row]
        dismiss(animated: true, completion: nil)
        delegate.setCurrency(value: currency.value, abreviation: currency.key, type: currencyType)
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currencyListViewModel.currenciesSorted = currencyListViewModel.currencies
        } else {
            search(forText: searchText)
        }
        tableView.reloadData()
    }
    func search(forText: String)  {
        if forText.isEmpty {
            currencyListViewModel.currenciesSorted = currencyListViewModel.currencies
        } else {
            let itensOnKey = currencyListViewModel.currencies.filter({ (item) -> Bool in
                return item.key.range(of: forText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            
            let itensOnValue = currencyListViewModel.currencies.filter({ (item) -> Bool in
                return item.value.range(of: forText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            
            currencyListViewModel.currenciesSorted = mergeLists(itensOnValue: itensOnValue, itensOnKey: itensOnKey)
        }
    }
}

func mergeLists(itensOnValue: [Dictionary<String, String>.Element], itensOnKey: [Dictionary<String, String>.Element]) -> [Dictionary<String, String>.Element] {
    var aux = itensOnKey
    for itemOnValue in itensOnValue {
        var contains = false
        for itemOnKey in itensOnKey {
            if itemOnKey == itemOnValue {
                contains = true
                break
            }
        }
        if !contains {
            aux.append(itemOnValue)
        }
        
    }
    return aux
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

