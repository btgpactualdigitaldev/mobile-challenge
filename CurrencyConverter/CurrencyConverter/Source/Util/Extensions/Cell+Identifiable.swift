//
//  Cell+Identifiable.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

protocol Identifiable {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
}

extension UITableViewCell: Identifiable {}

extension UICollectionViewCell: Identifiable {}
