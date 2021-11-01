//
//  Storyboarded.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 30/10/21.
//

import UIKit

public protocol Storyboarded {
    static func instantiated(_ storyboardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiated(_ storyboardName: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
