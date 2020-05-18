//
//  Coordinator.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    func start()
}
