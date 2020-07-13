//
//  HomeProtocol.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

enum CurrencyChange {
    case to
    case from
}

protocol HomePresenterOutput: class {
    func load(toViewModel: HomeViewModel, fromViewModel: HomeViewModel)
    func converted(sum: String)
    func error(viewModel: ErrorViewModel)
    func loading()
}
protocol HomePresenterInput {
    func viewDidLoad()
    func updateChanger(viewModel: HomeViewModel)
    func send(amount: Decimal)
    func changeCurrency(currency: CurrencyChange)
    func tryAgain()
    
}

protocol HomeInteractorInput {
    func loadRequest()
    func convert(toCurrency: String, fromCurrency: String, amount: Decimal)
}

protocol HomeInteractorOutput: class {
    func fetched(entites: [CurrencyEntity])
    func converted(sum: Decimal)
    func connectionFailure(error: NetworkError)
}
