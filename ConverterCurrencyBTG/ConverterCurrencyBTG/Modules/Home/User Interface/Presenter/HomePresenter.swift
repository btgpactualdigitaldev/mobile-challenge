//
//  HomePresenter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomePresenter: HomePresenterInput {
    weak var output: HomePresenterOutput?
    var route: HomeWireframe
    var interactor: HomeInteractorInput
    var viewModelTo: HomeViewModel!
    var viewModelFrom: HomeViewModel!
    var changerCurrency: CurrencyChange = .to
    
    init(route: HomeWireframe, interactor: HomeInteractorInput) {
        self.route = route
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.loadRequest()
    }
    
    func send(amount: Decimal) {
        interactor.convert(toCurrency: viewModelTo.currency, fromCurrency: viewModelFrom.currency, amount: amount)
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func converted(sum: Decimal) {
        guard let sumString = sum.toString()?.toCurrency()else {
            return
        }
        let textConvert = "Valor Convertido é: \(sumString)"
        self.output?.converted(sum: textConvert)
    }
    
    func fetched(entites: [CurrencyEntity]) {
        guard let to = entites.first(where: { $0.currency == "BRL"}),
            let from =  entites.first(where: { $0.currency ==  "USD"}) else {
                return
        }
        viewModelTo = HomeViewModel(name: to.name, currency: to.currency, imageView: UIImage(named: to.currency.lowercased()))
        viewModelFrom = HomeViewModel(name: from.name, currency: from.currency, imageView: UIImage(named: from.currency.lowercased()))
        DispatchQueue.main.async {
            self.output?.load(toViewModel: self.viewModelTo, fromViewModel: self.viewModelFrom)
        }
    }
    
    func updateChanger(viewModel: HomeViewModel) {
        switch changerCurrency {
        
        case .to:
            viewModelTo = viewModel
        case .from:
            viewModelFrom = viewModel
        }
        
        DispatchQueue.main.async {
            self.output?.load(toViewModel: self.viewModelTo, fromViewModel: self.viewModelFrom)
        }
    }
    
    func changeCurrency(currency: CurrencyChange) {
        changerCurrency = currency
        switch changerCurrency {
    
        case .to:
            route.showList(removeSymbol: viewModelFrom.currency)
        case .from:
            route.showList(removeSymbol: viewModelTo.currency)
        }
    }
}
