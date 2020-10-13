//
//  ListCurrencyViewController.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import UIKit

class ListCurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tblCurrencies: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchActive: Bool = false
    var lblNothing: UILabel!
    
    var currencies: [CurrencyInfo] = []
    var filteredDataSource: [CurrencyInfo] = []
    
    var userDefault = UserDefaults.standard
    
    var currencyType: Constants.CurrencyType?
    var selectedCurrency: CurrencyInfo?
    
    weak var delegate: SelectedCurrencyDelegate?
    
    private var service: ApiService!
    
    var viewLoading: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service = ApiService()
        
        tblCurrencies.delegate = self
        tblCurrencies.dataSource = self
        
        searchBar.delegate = self
        
        lblNothing = UILabel()
        lblNothing.text = "Currency not found."
        lblNothing.textAlignment = .center
        lblNothing.numberOfLines = 0
        
        loadCurrencies()
    }
    
    //MARK: Functions
    func showAlert(_ msg: String) {
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func showLoading(onView: UIView, show: Bool) {
        
        if show {
            let spnView = UIView.init(frame: onView.bounds)
            spnView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            
            let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
            activityIndicator.startAnimating()
            activityIndicator.center = spnView.center
            
            DispatchQueue.main.async {
                spnView.addSubview(activityIndicator)
                onView.addSubview(spnView)
            }
            
            viewLoading = spnView
            
        } else {
            
            DispatchQueue.main.async {
                self.viewLoading?.removeFromSuperview()
                self.viewLoading = nil
            }
            
        }
        
    }
    
    private func loadCurrencies() {
        
        self.showLoading(onView: self.view, show: true)
        
        self.service.getListCurrency {
            
            (response) in
            
            if response.success {
                
                for item in response.currencies {
                    self.currencies.append(CurrencyInfo(item.key, item.value))
                }
                
                self.currencies.sort(by: { $0.initial < $1.initial})
                
                DispatchQueue.main.async {
                    self.tblCurrencies.reloadData()
                    self.showLoading(onView: self.view, show: false)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.showLoading(onView: self.view, show: false)
                    self.showAlert("Oops...Something went wrong!\n Try again in a moment")
                }
                
            }
            
        }
        
        //        let fileUrl = Bundle.main.url(forResource: "currencies.json", withExtension: nil)
        //        let jsonData = try! Data(contentsOf: fileUrl!)
        //
        //        do {
        //
        //            let result = try JSONDecoder().decode(ResponseCurrencyInfo.self, from: jsonData)
        //
        //            if result.success {
        //
        //                for item in result.currencies {
        //
        //                    currencies.append(CurrencyInfo(item.key, item.value))
        //
        //                }
        //
        //                currencies.sort(by: { $0.initial < $1.initial})
        //
        //            }
        //
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        
    }
    
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //
    //        if searchText.isEmpty {
    //            filteredDataSource = currencies
    //        } else {
    //            filteredDataSource = currencies.filter(
    //                { $0.initial.lowercased().contains(searchText.lowercased())
    //                    || $0.fullName.lowercased().contains(searchText.lowercased())
    //                })
    //        }
    //
    //        tblCurrencies.reloadData()
    //    }
    //
    
    //MARK: SeachBar Delegates
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredDataSource = currencies.filter(
            {
                $0.initial.lowercased().contains(searchText.lowercased())
                || $0.fullName.lowercased().contains(searchText.lowercased())
            })
        
        if filteredDataSource.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        
        tblCurrencies.reloadData()

    }
    
    //MARK: TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
        
        if searchActive {
            return filteredDataSource.count
        }
        
        return currencies.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableViewCell
        
        if searchActive {
            cell.prepare(with: filteredDataSource[indexPath.row])
        } else {
            cell.prepare(with: currencies[indexPath.row])
        }
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableViewCell
//
//        if filteredDataSource.count == 0 {
//            cell.prepare(with: currencies[indexPath.row])
//        } else {
//            cell.prepare(with: filteredDataSource[indexPath.row])
//        }
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let curr: CurrencyInfo
        
        if filteredDataSource.count > 0 {
            curr = filteredDataSource[indexPath.row]
        } else {
            curr = currencies[indexPath.row]
        }
        
        self.selectedCurrency = CurrencyInfo(curr.initial, curr.fullName)
        
        switch self.currencyType {
        
        case .origin:
            self.selectedCurrency?.currencyType = .origin
            self.delegate?.setSelectedCurrency(self.selectedCurrency!)
            
        case .target:
            self.selectedCurrency?.currencyType = .target
            self.delegate?.setSelectedCurrency(self.selectedCurrency!)
            
        default:
            break
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

