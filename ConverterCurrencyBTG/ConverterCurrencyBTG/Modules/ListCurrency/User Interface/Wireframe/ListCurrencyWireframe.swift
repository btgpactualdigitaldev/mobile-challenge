//
//  ListCurrencyWireframe.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit


class ListCurrencyWireframe {
    
    weak var output: ListCurrencyWireframeOuput?
    weak var viewController: ListViewCurrency?
    
    func makeScreen(removeSymbol: String) -> ListViewCurrency {
        let interactor = ListCurrencyInteractor(manager: CurrencyManager(client: CurrencyAPIClient()))
        let presenter = ListCurrencyPresenter(interactor: interactor, wireframe: self, removeSymbol: removeSymbol)
        interactor.output = presenter
        let viewController = ListViewCurrency()
        viewController.presenter = presenter
        presenter.ouput = viewController
        self.viewController = viewController
        return viewController
    }
    
    func updateCurrency(viewModel: HomeViewModel) {
        output?.updateCurrency(currency: viewModel)
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func dismiss(){
        viewController?.dismiss(animated: true, completion: nil)
    }
}
