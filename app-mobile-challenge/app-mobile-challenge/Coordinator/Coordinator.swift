//
//  Coordinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

// Coordinator Protocol

protocol Coordinator {

    // Properties
    
    var navigationController: UINavigationController { get set }

    // Methods

    func start()
}
