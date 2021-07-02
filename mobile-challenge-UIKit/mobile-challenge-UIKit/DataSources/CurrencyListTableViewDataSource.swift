//
//  CurrencyListTableViewDataSource.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

class CurrencyListTableViewDataSource: NSObject, UITableViewDataSource {

    var setNumberOfRows: (() -> Int) = { return 0 }
    var getCurrencyForRowAt: ((Int) -> Currency?) = { _ in return nil }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let currency = getCurrencyForRowAt(indexPath.row) else {
            return UITableViewCell()
        }

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = currency.code
        cell.detailTextLabel?.text = currency.name

        return cell
    }
}
