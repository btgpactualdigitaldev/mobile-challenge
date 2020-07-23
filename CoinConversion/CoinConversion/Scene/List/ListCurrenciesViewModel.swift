//
//  ListCurrenciesViewModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - SortType
enum SortType {
    case name
    case code
}

// MARK: - ListCurrenciesViewModelDelegate
protocol ListCurrenciesViewModelDelegate: class {
    func didStartLoading()
    func didHideLoading()
    func didReloadData()
    func didFail(with title: String,
                 message: String,
                 buttonTitle: String,
                 noConnection: Bool,
                 dataSave: Bool
    )
}

// MARK: - Main
class ListCurrenciesViewModel {
    weak var delegate: ListCurrenciesViewModelDelegate?
    
    private var service: ListCurrenciesService?
    private var conversion: Conversion?
    private var router: ListCurrenciesRouter?
    private var currencies: [ListCurrenciesModel]?
    private var dataManager: DataManager?
    
    private(set) var listCurrencies: [ListCurrenciesModel]?
    private(set) var isSort = Bool()
    
    init(service: ListCurrenciesService,
         conversion: Conversion,
         dataManager: DataManager,
         router: ListCurrenciesRouter
    ) {
        self.service = service
        self.conversion = conversion
        self.dataManager = dataManager
        self.dataManager?.delegate = self
        self.router = router
    }
}

// MARK: - PublicMethods
extension ListCurrenciesViewModel {
    func fetchListCurrencies(isRefresh: Bool) {
        if !hasDatabaseListCurrencies() || isRefresh {
            
            delegate?.didStartLoading()
            isSort = false
            
            service?.fetchListCurrencies(success: { listCurrencies in
                self.delegate?.didHideLoading()
                
                switch listCurrencies.success {
                case false:
                    self.handleError(whit: .init(type: .noAuthorized))
                    return
                default:
                    self.currencies = self.handleListCurrencies(
                        with: listCurrencies
                    )
                    
                    self.listCurrencies = self.handleListCurrencies(
                        with: listCurrencies
                    )
                    
                    DispatchQueue.main.async {
                        self.dataManager?.syncListCurrencies(currencies: self.listCurrencies!)
                        self.delegate?.didReloadData()
                    }
                }
            }, fail: { serviceError in
                DispatchQueue.main.async {
                    self.delegate?.didHideLoading()
                    self.handleError(whit: serviceError)
                }
            })
        }
    }
    
    func searchListCurrencies(whit text: String) {
        if text.count > 0 {
            var list = currencies
            list = list?.filter {
                $0.name.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(
                    text.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                    ) ||
                    $0.code.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(
                        text.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                )
            }
            listCurrencies = list
            delegate?.didReloadData()
            return
        }
        
        listCurrencies = currencies
        isSort = false
        delegate?.didReloadData()
    }
    
    func fetchLisSortBy(_ type: SortType, with list: [ListCurrenciesModel]) {
        self.listCurrencies = sortBy(type: type, with: list)
        isSort = true
        delegate?.didReloadData()
    }
    
    func chosenCurrencies(code: String, name: String) {
        guard let conversion = conversion else {
            fatalError("conversion type can't be nil")
        }
        router?.dismissToConversion(code, name, conversion)
    }
}

// MARK: - PrivateMethods
extension ListCurrenciesViewModel {
    private func handleListCurrencies(with listCurrencies: ListCurrencies) -> [ListCurrenciesModel] {
        var list = listCurrencies.currencies.map { list -> ListCurrenciesModel in
            return ListCurrenciesModel(
                name: list.value, code: list.key
            )
        }
        
        list = list.sorted {
            $0.name < $1.name
        }
        
        return list
    }
    
    private func hasDatabaseListCurrencies() -> Bool {
        if dataManager?.hasDatabaseListCurrencies() ?? false {
            currencies = dataManager?.fetchDatabaseListCurrencies()
            listCurrencies = currencies
            
            guard var currencies = currencies,
                let _ = listCurrencies else {
                    fatalError("provisorio fazer tratamento")
            }
            
            currencies = currencies.sorted {
                $0.name < $1.name
            }
            
            self.listCurrencies = currencies
            self.currencies = currencies
            isSort = false
            
            return true
        }
        return false
    }
    
    func sortBy(type: SortType, with list: [ListCurrenciesModel]) -> [ListCurrenciesModel] {
        switch type {
        case .code:
            return list.sorted {
                $0.code < $1.code
            }
        case .name:
            return list.sorted {
                $0.name < $1.name
            }
        }
    }
    
    private func handleError(whit error: ServiceError) {
        guard error.type == .noConnection else {
            guard hasDatabaseListCurrencies() else {
                delegate?.didFail(with: "Erro encontrado",
                                  message: "Desculpe-nos pelo erro. Iremos contorná-lo o mais rápido possível. \nMotivo: \(error.type.description)",
                    buttonTitle: "OK",
                    noConnection: false,
                    dataSave: false
                )
                
                return
            }
            
            delegate?.didFail(with: "Erro encontrado",
                              message: "Desculpe-nos pelo erro. \nNão conseguimos atualizar as cotas continue navegando com os dados da última atualização.",
                              buttonTitle: "OK",
                              noConnection: false,
                              dataSave: false
            )
            return
        }
        
        if hasDatabaseListCurrencies() {
            delegate?.didFail(with: "Problema na conexão",
                              message: "Encontramos problemas com a conexão. \nNão conseguimos atualizar as cotas continue navegando com os dados da última atualização.",
                              buttonTitle: "OK",
                              noConnection: true,
                              dataSave: true
            )
            return
        }
        delegate?.didFail(with: "Problema na conexão",
                          message: "Encontramos problemas com a conexão. Tente ajustá-la para continuar navegando.",
                          buttonTitle: "Tentar novamente",
                          noConnection: true,
                          dataSave: false
        )
    }
}
// MARK: - DataManagerDelegate
extension ListCurrenciesViewModel: DataManagerDelegate {
    func didDataManagerFail(with reason: String) {
        delegate?.didFail(with: "Erro encontrado",
                          message: "Desculpe-nos pelo erro. Não conseguimos salvar seus dados para uso off-line. \nMotivo: \(reason)",
            buttonTitle: "Continuar Navegando",
            noConnection: false,
            dataSave: false
        )
    }
}
