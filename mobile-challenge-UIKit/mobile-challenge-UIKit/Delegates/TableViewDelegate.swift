//
//  TableViewDelegate.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    var didSelectRowAt: (Int) -> Void = { _ in}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt(indexPath.row)
    }
}
