//
//  Coordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

protocol Coordinator: AnyObject {
        
    var presenter: UINavigationController { get set }
    func start()
}
