//
//  AppColors.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 26/11/20.
//

import UIKit

enum AppColors {
    case appBackground
    
    var color: UIColor? {
        switch self {
        case .appBackground:
            return UIColor(named: "AppBackground")
        }
    }
}
