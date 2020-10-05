//
//  Coordinator.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit

/// Base `Coordinator`.
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
