//
//  CurrencyListViewController.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var presenter = CurrencyListPresenter(with: self)
    @IBOutlet weak var currencyListTableView: UITableView!
    var currenciesArray: [CurrencyResult] = [CurrencyResult]()
    
    var source: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currencyListTableView.dataSource = self
        self.currencyListTableView.delegate = self

        presenter.getList()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection    section: Int) -> Int {
        return currenciesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! CurrencyCustomCustomCell
        cell.configureCell(item: currenciesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueMainViewController") {
            let indexPath = self.currencyListTableView.indexPathForSelectedRow
            if (source == "FROM") {
                UserDefaults.standard.set(self.currenciesArray[indexPath!.row].code ?? "", forKey: "FROM_CODE")
                UserDefaults.standard.set(self.currenciesArray[indexPath!.row].description ?? "", forKey: "FROM_DESCRIPTION")
                UserDefaults.standard.synchronize()
            } else if(source == "TO") {
                UserDefaults.standard.set(self.currenciesArray[indexPath!.row].code ?? "", forKey: "TO_CODE")
                UserDefaults.standard.set(self.currenciesArray[indexPath!.row].description ?? "", forKey: "TO_DESCRIPTION")
                UserDefaults.standard.synchronize()
            }
        }
    }

}

extension CurrencyListViewController: CurrencyListPresenterView {
    
    func loadTableView(currenciesArray: [CurrencyResult]){
        self.currenciesArray = currenciesArray
        currencyListTableView.reloadData()
    }
    
}
