//
//  ConversionListTableViewController.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import UIKit

protocol ConversionListTableViewDelegate {
    func receiveSelectedCoin(coinModel: CoinViewModel)
}

class ConversionListTableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: ConversionListTableViewDelegate?
    
    private var viewModel: CoinListViewModel!
    
    init() {
        super.init(nibName: "ConversionListTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewUtils.showLoading(viewController: self)
        
        self.viewModel = CoinListViewModel()
        self.viewModel.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConversionListTableCell.nib(), forCellReuseIdentifier: ConversionListTableCell.cellIdentifier)
        
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        
        title = NSLocalizedString("title_conversion_list_view_controller", comment: "")
    }
    
}

extension ConversionListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listCoins?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversionListTableCell.cellIdentifier, for: indexPath) as! ConversionListTableCell
        
        cell.configure(with: viewModel.listCoins?[indexPath.row] ?? CoinViewModel(initials: "", name: ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coinModel = viewModel.listCoins?[indexPath.row] {
            delegate?.receiveSelectedCoin(coinModel: coinModel)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension ConversionListTableViewController: CoinListViewModelDelegate {
    func didErrorOcurred(error: String) {
        ViewUtils.hideLoading()
        DispatchQueue.main.async {
            ViewUtils.alert(self, title: NSLocalizedString("Erro", comment: "") , error, btnLabel: NSLocalizedString("understand", comment: ""), completion: nil) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func didGetListModel() {
        ViewUtils.hideLoading()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ConversionListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(by: searchText)
    }
}
