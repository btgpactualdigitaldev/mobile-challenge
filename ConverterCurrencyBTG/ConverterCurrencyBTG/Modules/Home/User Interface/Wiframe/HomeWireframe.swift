//
//  HomeWireframe.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomeWireframe {
    weak var viewController: HomeController?
    
    func makeScreen() -> HomeController {
        let localDataInteractor = LocalDataInteractor(manager: LocalDataManager())
        let interactor = HomeInteractor(manager: CurrencyManager(client: CurrencyAPIClient()), localDataInteractor: localDataInteractor)
        let presenter = HomePresenter(route: self, interactor: interactor)
        interactor.output = presenter
        let homeController = HomeController()
        homeController.presenter = presenter
        presenter.output = homeController
        viewController = homeController
        return homeController
    }
    
    func showList(removeSymbol: String) {
        let listWiframe = ListCurrencyWireframe()
        listWiframe.output = self
        let navigation = UINavigationController(rootViewController: listWiframe.makeScreen(removeSymbol: removeSymbol))
        navigation.modalPresentationStyle = .fullScreen
        viewController?.present(navigation, animated: true, completion: nil)
    }
}

extension HomeWireframe: ListCurrencyWireframeOuput {
    func updateCurrency(currency: HomeViewModel) {
        viewController?.presenter.updateChanger(viewModel: currency)
    }
    
    
}
