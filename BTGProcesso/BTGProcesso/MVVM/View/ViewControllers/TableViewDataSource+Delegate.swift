//
//  TableViewDataSource+Delegate.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 09/12/20.
//

import UIKit

class DataSource: NSObject {
    
    var coins: [String] = []
    var cellID: String
   
    
    init(cellID: String) {
        self.cellID = cellID
    }
}

extension DataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = coins[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
}

class Delegate: NSObject {
    var view: QuotaView?
    var identifier: String?
    var didSelectItem: ((IndexPath, String?) -> ())?
}

extension Delegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if 0 == indexPath.row {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        didSelectItem?(indexPath,cell?.textLabel?.text)
        if identifier == "QuotaTableViewtCellOrigin" {
            view?.animationTableViewOrigin()
        } else {
            view?.animationTableViewDestiny()
        }
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
}
