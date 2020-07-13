//
//  ListCurrencyProtocol.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

protocol ListCurrencyPresenterInput {
    var searchText: String { get set}
    var searchIsActive: Bool {get set}
    var title: String { get set}
    var message: String{ get set }
    var isLoading: Bool {get set}
    func viewDidLoad()
    func didSelected(viewModel: ListViewModel)
    func updateSearch()
    func didTap()
}

protocol ListCurrencyPresenterOuput: class {
    func loadView(viewModels: [ListViewModel])
}
protocol ListCurrencyInteractorInput {
    func loadData()
    func searchEntity(text: String, isActive: Bool)
}

protocol ListCurrencyInteractorOuput: class {
    func fetched(entites: [CurrencyEntity])
}

protocol ListCurrencyWireframeOuput: class {
    func updateCurrency(currency: HomeViewModel)
}
