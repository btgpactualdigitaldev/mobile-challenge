//
//  AppCoordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow?
    
    var presenter: UINavigationController
    private var exchangeCoordinator: ExchangeCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        presenter = UINavigationController()
        
        exchangeCoordinator = ExchangeCoordinator(presenter: presenter)
    }
    
    func start() {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = presenter
        exchangeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
