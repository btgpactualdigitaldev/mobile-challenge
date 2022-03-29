//
//  NavigationControllerSpy.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit

final class UINavigationControllerSpy: UINavigationController {
    
    var pushViewControllerCalled = false
    
    override func pushViewController(
        _ viewController: UIViewController, animated: Bool
    ) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalled = true
    }
    
    var presentCalled = false
    
    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        super.present(
            viewControllerToPresent, animated: flag, completion: completion
        )
        presentCalled = true
    }
    
    var popToRootCalled = false
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
        popToRootCalled = true
        return [UIViewController()]
    }
    
}
