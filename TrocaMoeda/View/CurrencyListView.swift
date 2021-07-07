//
//  CurrencyListView.swift
//  TrocaMoeda
//
//  Created by mac on 23/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import UIKit

class CurrencyListView: UIViewController {

    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet weak var currencySearchField: UITextField!
    let viewModel = CurrencyListViewModel()
    var pressedButton: String? = nil
    var pressedButtonCurrentTitle: String? = nil
    var currencyCodes: [CurrencyTableItem] = []
    var selectedCurrency: CurrencyTableItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencies(from: K.API.currencyListURL, type: .CurrencyList, completion: ({
            self.currencyCodes = self.viewModel.CTIArray
            DispatchQueue.main.async {
                self.currencyTable.delegate = self
                self.currencyTable.dataSource = self
                self.currencyTable.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
                self.currencyTable.reloadData()
            }
        }), errorHandler: ({
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erro de Conexão", message: "Por favor, verifique sua conexão ou tente novamente mais tarde.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                        self.navigationController?.popToRootViewController(animated: true)
                      case .cancel:
                        self.navigationController?.popToRootViewController(animated: true)
                      case .destructive:
                        self.navigationController?.popToRootViewController(animated: true)
                      @unknown default:
                        self.navigationController?.popToRootViewController(animated: true)
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        currencySearchField.delegate = self
        // Do any additional setup after loading the view.
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

extension CurrencyListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencyBlock = currencyCodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CurrencyCell
        if let code = currencyBlock.currency.first?.key, let name = currencyBlock.currency.first?.value {
            cell.currencyCode.text = code
            cell.currencyName.text = name
            cell.checkMark.isHidden = true
            if let originButtonTitle = pressedButtonCurrentTitle {
                if name == originButtonTitle {
                    cell.checkMark.isHidden = false
                }
            }
        }
        return cell
    }
}

extension CurrencyListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencyBlock = currencyCodes[indexPath.row]
        selectedCurrency = currencyBlock
        if let rootView = navigationController?.viewControllers.first as? ViewController, let name = currencyBlock.currency.first?.value, let code = currencyBlock.currency.first?.key {
            if let button = pressedButton {
                if button == "second" {
                    rootView.secondSelectedCurrency = code
                    rootView.secondCurrencyButton.setTitle(name, for: .normal)
                } else {
                    rootView.firstSelectedCurrency = code
                    rootView.firstCurrencyButton.setTitle(name, for: .normal)
                }

            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CurrencyListView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currencySearchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currencySearchField.text != "" {
            return true
        } else {
            currencySearchField.placeholder = "Digite o nome ou código da moeda"
            currencyCodes = viewModel.CTIArray
            viewModel.destroySearch()
            currencyTable.reloadData()
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchTerm = currencySearchField.text {
            viewModel.searchCurrency(with: searchTerm)
            currencyCodes = viewModel.searchArray
            DispatchQueue.main.async {
                self.currencyTable.reloadData()
            }
        } else {
            currencyCodes = viewModel.CTIArray
            DispatchQueue.main.async {
                self.currencyTable.reloadData()
            }
        }
    }
}
