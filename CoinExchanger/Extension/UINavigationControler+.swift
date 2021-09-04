//
//  UINavigationControlerExtension.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 22/07/20.
//

import UIKit

extension UINavigationController {

    func popToClassController(_ controller: AnyClass, animated: Bool) {
        if let vc = viewControllers.filter({$0.isKind(of: controller)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
