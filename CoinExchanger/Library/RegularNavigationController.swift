//
//  RegularNavigationController.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 18/08/21.
//

import UIKit

class RegularNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    init(_ viewController: UIViewController) {
        super.init(rootViewController: viewController)
        delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        if #available(iOS 13, *) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        let backButton = RegularBackButton(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
    }
}
