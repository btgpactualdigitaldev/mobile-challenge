//
//  Router.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit

class Router {
    public static let shared = Router()
    
    // Troca de tela
    func setViewController(viewController: UIViewController) {
        let navigation = SceneDelegate.shared?.navigationVC
        navigation?.pushViewController(viewController, animated: true)
    }
    
    // Apresenta view controller em cima do último view controller apresentado, ou apresenta na raiz
    func presentViewController(viewController: UIViewController) {
        let navigation = SceneDelegate.shared?.navigationVC
        if let presentedVC = navigation?.presentedViewController {
            presentedVC.present(viewController, animated: true)
        } else {
            navigation?.present(viewController, animated: true)
        }
    }
}
