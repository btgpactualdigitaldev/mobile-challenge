//
//  Storyboarded.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let name = NSStringFromClass(self)
        let className = name.components(separatedBy: ".")[1]
        let storyboardName = Identifier.Storyboard.Main.rawValue
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: className) as! Self
    }
}
