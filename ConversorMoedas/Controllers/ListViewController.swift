//
//  ListagemViewController.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var switchSearchType: UISwitch!
    @IBOutlet weak var switchOrder: UISwitch!
    @IBOutlet weak var lbSwitchSearchType: UILabel!
    @IBOutlet weak var lbSwitchOrder: UILabel!
    
    var currencies: [CurrenciesList.Currencies] = []
    var searchCurrencies: [CurrenciesList.Currencies] = []
    
    
    @IBAction func didSwitchSearchType(_ sender: Any) {
       
        if switchSearchType.isOn {
            lbSwitchSearchType.text = "Sigla"
        }else{
            lbSwitchSearchType.text = "País"
        }
        
        switchButtons()
    }
    
    @IBAction func didSwitchOrderTap(_ sender: Any) {

        if switchOrder.isOn {
            lbSwitchOrder.text = "A - Z"
        }else{
            lbSwitchOrder.text = "Z - A"
        }
        
        switchButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        self.searchBar.delegate = self
        CurrenciesList().getList({ list in
            self.currencies = list.map {c in CurrenciesList.Currencies(key: c.key, value: c.value)}
            self.currencies = self.currencies.sorted(by: {a, b in a.key.localizedCaseInsensitiveCompare(b.key) == .orderedAscending})
            self.searchCurrencies = self.currencies
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }, {error in
            self.showMessage("Erro", error as! String)
        })
    }
}

extension ListViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CurrencyCollectionViewCell
        var value = ""
        
        if switchSearchType.isOn {
            value = "\(currencies[indexPath.item].key)"
        }else{
            value = "\(currencies[indexPath.item].value)"
        }
        cell?.setValue(value: value)
        return cell!
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.currencies.removeAll()
            
        for item in searchCurrencies {
            if item.key.lowercased().contains(searchBar.text!.lowercased()) || item.value.lowercased().contains(searchBar.text!.lowercased()){
               self.currencies.append(item)
           }
        }
        
       if (searchBar.text!.isEmpty){
           self.currencies = self.searchCurrencies
       }
       
       self.collectionView?.reloadData()
    }
    
    func switchButtons(){
        if switchOrder.isOn {
            if switchSearchType.isOn {
                self.currencies = self.currencies.sorted(by: {a, b in a.key.localizedCaseInsensitiveCompare(b.key) == .orderedAscending})
            }else{
                self.currencies = self.currencies.sorted(by: {a, b in a.value.localizedCaseInsensitiveCompare(b.value) == .orderedAscending})
            }
            self.collectionView?.reloadData()
        }else{
                if switchSearchType.isOn {
                self.currencies = self.currencies.sorted(by: {a, b in b.key.localizedCaseInsensitiveCompare(a.key) == .orderedAscending})
            }else{
                self.currencies = self.currencies.sorted(by: {a, b in b.value.localizedCaseInsensitiveCompare(a.value) == .orderedAscending})
            }
            self.collectionView?.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = presentingViewController as? ExchangeViewController
        let key = currencies[indexPath.item].key
        let value = currencies[indexPath.item].value
        let tuple = (key: key, value: value)
        vc?.setCurrency(tuple)
        dismiss(animated: true, completion: nil)
    }
}

extension ListViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
