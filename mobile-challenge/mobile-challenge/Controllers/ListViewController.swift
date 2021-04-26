//
//  ListViewController.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 24/04/21.
//

import UIKit

enum SortEnum: Int {
    case nameAsc = 0
    case nameDesc = 1
    case siglaAsc = 2
    case siglaDesc = 3
    
    init(index: Int) {
        switch index {
        case 0: self = .nameAsc
        case 1: self = .nameDesc
        case 2: self = .siglaAsc
        case 3: self = .siglaDesc
        default:
            self = .nameAsc
        }
    }
    
}

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    
    public var currencySelectedEnum: CurrencySelectedEnum = .ONE
    public var delegate: ChooseCurrencyDelegate?
    private var sortEnum = SortEnum.nameAsc {
        didSet {        
            sortList()
        }
    }
    
    var currencies: [CurrencyDescription] = [] {
        didSet {
            filterCurrencies = currencies
        }
    }
    var filterCurrencies: [CurrencyDescription] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        sortEnum = SortEnum(index: sortEnum.rawValue + 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.pullToRefresh {
            self.getList()
        }
        if let refreshControl = tableView.refreshControl {
            refreshControl.beginRefreshing()
        }
//        view.hideKeyboard()
        getList()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func sortList() {
        DispatchQueue.main.async {
            switch self.sortEnum {
            case SortEnum.nameAsc:
                self.sortButton.setTitle("Nome", for: .normal)
                self.sortButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
                self.filterCurrencies = self.filterCurrencies.sorted(by: {$0.name < $1.name})
            case SortEnum.nameDesc:
                self.sortButton.setTitle("Nome", for: .normal)
                self.sortButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
                self.filterCurrencies = self.filterCurrencies.sorted(by: {$0.name > $1.name})
            case SortEnum.siglaAsc:
                self.sortButton.setTitle("Siglas", for: .normal)
                self.sortButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
                self.filterCurrencies = self.filterCurrencies.sorted(by: {$0.key < $1.key})
            case SortEnum.siglaDesc:
                self.sortButton.setTitle("Siglas", for: .normal)
                self.sortButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
                self.filterCurrencies = self.filterCurrencies.sorted(by: {$0.key > $1.key})
            }
        }
        
    }
    
    private func getList() {
        APICurrency.getList { (result) in
            DispatchQueue.main.async {
                self.tableView.stopPullToRefresh()
            }
            switch(result) {
            case .success(let currencyNameModel):
                self.currencies = currencyNameModel.currencies.array
                self.sortList()
                
            case .failure(_):
                AlertMessage.showOk(title: "Atenção", message: "Parece que algo deu errado, tente novamente.")
            case .connectivityError:break
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        cell.currencyDescription = filterCurrencies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(currencyDescription: filterCurrencies[indexPath.row], type: currencySelectedEnum)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filterCurrencies = currencies
        } else {
            filterCurrencies = currencies.filter {
                ($0.key + " " + $0.name).lowercased().contains(searchText.lowercased())
            }
            if filterCurrencies.isEmpty {
                tableView.setEmptyView(message: "A pesquisa \"\(searchText)\" não foi encontrada.")
            }
        }
    }
}
