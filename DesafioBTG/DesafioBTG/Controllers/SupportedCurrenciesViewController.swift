//
//  SupportedCurrenciesViewController.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 04/11/20.
//

import UIKit

class SupportedCurrenciesViewController: BaseViewController {
    
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var txtSearchCurrency: UISearchBar!
    
    private var currencyViewMode: CurrencyViewModel!
    private var dataSource: CurrencyTableViewDataSource<CurrencyTableViewCell, CurrencyInfo>!
    
    var userDefault = UserDefaults.standard
    private var filteredDataSource: [CurrencyInfo]!
    
    var currencyType: Constants.CurrencyType?
    var selectedCurrency: CurrencyInfo?
    weak var delegate: SelectedCurrencyDelegate?
    var searchActive: Bool = false
    
    //MARK: Override`s
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        txtSearchCurrency.delegate = self
        currencyTableView.delegate = self
    }
    
    //MARK: Function`s
    func bindViewModel() {
        
        showLoading(onView: self.view, show: true)
        
        self.currencyViewMode = CurrencyViewModel()
        self.currencyViewMode.bindViewModel = {
            self.loadDataSource()
        }
    }
    
    func loadDataSource() {
        
        if !searchActive {
            filteredDataSource = currencyViewMode.data.currencies
        }
        
        self.filteredDataSource.sort(by: { $0.initial < $1.initial})
        
        self.dataSource = CurrencyTableViewDataSource(
            cellIdentifier: "CurrencyTableViewCell",
            items: filteredDataSource, //currencyViewMode.data.currencies,
            configureCell: {
                (cell, viewModel) in
                cell.lblInitials.text = viewModel.initial
                cell.lblFullName.text = viewModel.fullName
            })
        
        DispatchQueue.main.async {
            self.currencyTableView.dataSource = self.dataSource
            self.currencyTableView.reloadData()
            
            self.showLoading(onView: self.view, show: false)
        }
        
    }
    
}

extension SupportedCurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let curr: CurrencyInfo
           
        curr = filteredDataSource[indexPath.row]
           
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

extension SupportedCurrenciesViewController: UISearchBarDelegate {
    
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
        
        if let searchText =  txtSearchCurrency.text {
            
            filteredDataSource = currencyViewMode.data.currencies.filter(
                {
                    $0.initial.lowercased().contains(searchText.lowercased())
                        || $0.fullName.lowercased().contains(searchText.lowercased())
                }
            )
        }
        
        if filteredDataSource.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.loadDataSource()
    }
    
}
