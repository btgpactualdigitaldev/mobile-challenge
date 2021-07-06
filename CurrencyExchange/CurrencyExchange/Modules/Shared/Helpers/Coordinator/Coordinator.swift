//
//  Coordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

protocol Coordinator: class {
    
    var presenter: UINavigationController { get set }
    func start()
    
}
