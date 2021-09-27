//
//  Coordinator.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 25/09/21.
//

import UIKit

protocol Coordinator {
    
    var currentNavigationController : UINavigationController! { get set }
    
    func start(navigationController: UINavigationController)
    func back()
    
}
