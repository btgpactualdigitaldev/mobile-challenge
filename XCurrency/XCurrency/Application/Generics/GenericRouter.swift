//
//  GenericRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class GenericRouter {

    // MARK: - Attributes
    var navigationController: UINavigationController!

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods
    func dismiss() {
        self.navigationController.popViewController(animated: true)
    }
}
