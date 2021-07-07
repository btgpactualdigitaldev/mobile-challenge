//
//  Coordinator.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
    func start()
}
