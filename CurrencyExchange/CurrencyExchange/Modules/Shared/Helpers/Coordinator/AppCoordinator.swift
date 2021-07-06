//
//  AppCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: Properties
    
    private let window: UIWindow?
    var presenter: UINavigationController
    private var exchangeCoordinator: ExchangeCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        self.presenter = UINavigationController()
        
        self.exchangeCoordinator = ExchangeCoordinator(presenter: presenter)
    }
    
    func start() {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = presenter
        self.exchangeCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    
}

