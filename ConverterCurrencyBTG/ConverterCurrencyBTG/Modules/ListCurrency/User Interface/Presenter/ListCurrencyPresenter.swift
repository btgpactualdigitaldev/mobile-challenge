//
//  ListCurrencyPresenter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class ListCurrencyPresenter: ListCurrencyPresenterInput {
    weak var ouput: ListCurrencyPresenterOuput?
    var wireframe: ListCurrencyWireframe
    var interactor: ListCurrencyInteractorInput
    var removeSymbol: String
    var searchText: String = ""
    var searchIsActive: Bool = false
    var title: String = ""
    var message: String = ""
    var isLoading: Bool = true
    
    var isSearchBarEmpty: Bool {
        return searchText.isEmpty
    }
    
    var isFiltering: Bool {
      return searchIsActive && !isSearchBarEmpty
    }
    
    init(interactor: ListCurrencyInteractorInput, wireframe: ListCurrencyWireframe, removeSymbol: String) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.removeSymbol = removeSymbol
    }
    
    func viewDidLoad() {
        title = "Carregando dados"
        message = "Aguarde buscando dados"
        self.interactor.loadData()
    }
    
    func didSelected(viewModel: ListViewModel) {
        let homeViewModel = HomeViewModel(name: viewModel.name, currency: viewModel.currency, imageView: viewModel.imageView)
        self.wireframe.updateCurrency(viewModel: homeViewModel)
    }
    
    func updateSearch() {
        interactor.searchEntity(text: self.searchText, isActive: isFiltering)
    }
    
    func didTap() {
        wireframe.dismiss()
    }
}

extension ListCurrencyPresenter: ListCurrencyInteractorOuput {
    
    func fetched(entites: [CurrencyEntity]) {
        let filtered = entites.filter({ $0.currency != removeSymbol })
        if filtered.count == .zero {
            title = "Opss Error"
            message = "Parecer que sua busca esta vazia :("
            isLoading = false
        }
        
        DispatchQueue.main.async {
        self.ouput?.loadView(viewModels: filtered.map({ ListViewModel(name: $0.name, currency: $0.currency, imageView: UIImage(named: $0.currency.lowercased())) }))
        }
    }
}
