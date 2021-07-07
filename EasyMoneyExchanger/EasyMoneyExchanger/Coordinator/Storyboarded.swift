//
//  Storyboarded.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(from storyboardName: UIStoryboard.Name) -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(from storyboardName: UIStoryboard.Name) -> Self? {
        let storyboardID = String(describing: self)
        let storyboard =  UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardID) as? Self
    }
}

extension UIStoryboard {
    enum Name: String {
        case exchangeScreen = "ExchangeScreen"
        case currenciesScreen = "SupportedCurrenciesScreen"
    }
}
