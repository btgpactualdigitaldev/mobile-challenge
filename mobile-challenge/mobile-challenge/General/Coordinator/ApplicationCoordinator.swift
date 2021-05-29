//
//  Coordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let quotationCoordinator: QuotationCoordinator
    let networkManager: NetworkManager
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.networkManager = NetworkManager()
        self.quotationCoordinator = QuotationCoordinator(navigationController: rootViewController, manager: networkManager)
    }
    
    func start() {
        window.rootViewController = rootViewController
        quotationCoordinator.start()
        window.makeKeyAndVisible()
    }
}
