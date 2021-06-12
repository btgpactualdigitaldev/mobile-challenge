//
//  MainCoordinator.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 08/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya
import UIKit

class CurrencyLiveCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    let controller: UIViewController
    
    init(with navigation: UINavigationController) {
        self.navigation = navigation
        let provider = MoyaProvider<ConvertCurrencyRouter>()
        let service = CurrencyLiveService(provider: provider)
        let viewModel = CurrencyLiveViewModel(service: service)
        self.controller = CurrencyLiveViewController(with: viewModel)
    }
    
    func start(presentation: Presentation) {
        switch presentation {
        case .present(let animated):
            self.navigation.present(controller, animated: animated, completion: nil)
        case .push(let animated):
            self.navigation.pushViewController(controller, animated: animated)
        case .sheetView:
            return
        }
    }
    
    internal func start(with presentation: Presentation) -> UIViewController {
        self.start(presentation: presentation)
        return self.controller
    }
}
