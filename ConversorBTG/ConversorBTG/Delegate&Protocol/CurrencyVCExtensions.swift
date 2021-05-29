//
//  CurrencyVCExtensions.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit

//Extensão da CurrencyViewController para configurar os dados da tableView
extension CurrencyViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myViewModel.allCurrencies.count == 0{
            return 1
        }else{
            return self.myViewModel.allCurrencies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.myViewModel.setupTableView(tableView: tableView, indexPath: indexPath)
    }
}
