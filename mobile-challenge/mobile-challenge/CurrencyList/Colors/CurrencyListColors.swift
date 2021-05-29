//
//  CurrencyListColors.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

enum CurrencyListColors {
    case currencyTitle
    case code
    case name
    case quotation
    case sectionBackground
    case cellBackground
    case searchBarBackground
    
    var color: UIColor? {
        switch self {
        case .currencyTitle:
            return UIColor(named: "CurrencyTitle")
        case .code:
            return UIColor(named: "Code")
        case .name:
            return UIColor(named: "Name")
        case .quotation:
            return UIColor(named: "Quotation")
        case .sectionBackground:
            return UIColor(named: "SectionBackground")
        case .cellBackground:
            return UIColor(named: "CellBackground")
        case .searchBarBackground:
            return UIColor(named: "SearchBarBackground")
        }
    }
}
