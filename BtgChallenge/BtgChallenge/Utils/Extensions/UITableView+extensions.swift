//
//  UITableView+extensions.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 14/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

extension UITableView {
    func registerClass<T: UITableViewCell>(_ type: T.Type) {
        register(type.self, forCellReuseIdentifier: type.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: type.reusableIdentifier, for: indexPath) as? T
        return cell ?? T()
    }
}
