//
//  Coordinator.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit

protocol AnyCoordinator {
    var navigationController: UINavigationController { get }
    func start()
}
