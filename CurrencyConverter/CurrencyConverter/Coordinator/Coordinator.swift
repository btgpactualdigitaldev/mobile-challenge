//
//  Coordinator.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

protocol Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController { get set }
    
    // MARK: - Methods
    func start()
}
