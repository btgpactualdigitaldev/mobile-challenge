//
//  CurrenciesViewModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class CurrenciesViewModel {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private var currenciesService: CurrenciesServiceRepository
    private var currenciesPersistence: CurrenciesPersistenceRepository
    private let allCurrencies = BehaviorRelay<[CurrencyModel]>(value: [])
    var currencies = BehaviorRelay<[CurrencyModel]>(value: [])
    var isLoading = BehaviorRelay(value: true)
    let filter = BehaviorRelay<String?>(value: nil)
    let sortAZ = BehaviorRelay<Bool>(value: true)
    let fromText = BehaviorRelay<String>(value: "")
    let toText = BehaviorRelay<String>(value: "")
    let fromCurrency = BehaviorRelay<CurrencyModel>(value: CurrencyModel())
    let toCurrency = BehaviorRelay<CurrencyModel>(value: CurrencyModel())
    let converterEnabled = BehaviorRelay<Bool>(value: false)
    let cleanEnabled = BehaviorRelay<Bool>(value: false)
    let tryAgainTextHidden = BehaviorRelay<Bool>(value: true)
    let tryAgainButtonHidden = BehaviorRelay<Bool>(value: true)

    init(currenciesService: CurrenciesServiceRepository, currenciesPersistence: CurrenciesPersistenceRepository) {
        self.currenciesService = currenciesService
        self.currenciesPersistence = currenciesPersistence
        fetchCurrencies()
        searchCurrencies()
        sortCurrencies()
    }

    // MARK: - Actions

    func fetchCurrencies() {
        self.isLoading.accept(true)
        self.tryAgainTextHidden.accept(true)
        self.tryAgainButtonHidden.accept(true)
        currenciesService.getCurrencies()
            .subscribe { event -> Void in
                switch event {
                case let .success(next):
                    self.isLoading.accept(false)
                    
                    //Sempre que conseguir buscar as moedas e cotas atualizadas salva locamente
                    let currencies = self.sort(self.sortAZ.value, next)
                    self.currenciesPersistence.saveAll(currencies: currencies)
                    
                    self.currencies.accept(currencies)
                    self.allCurrencies.accept(currencies)
                case .error:
                    self.isLoading.accept(false)
                    
                    //Caso der erro ao buscar as moedas por falta de internet, se o usuário já tiver conseguido buscar alguma vez é utilizado a persistência local.
                    let currencies = Array(self.currenciesPersistence.getCurrencies())
                    if currencies.count > 0 {
                        self.currencies.accept(currencies)
                        self.allCurrencies.accept(currencies)
                    } else {
                        //Se der erro ao buscar pela internet e não tiver salvo nada ainda na persistência, exibida a lógica de try again.
                        self.tryAgainTextHidden.accept(false)
                        self.tryAgainButtonHidden.accept(false)
                    }
                }
            }.disposed(by: disposeBag)
    }

    func searchCurrencies() {
        Observable.combineLatest(allCurrencies.asObservable(), filter.asObservable()) { (all: [CurrencyModel], text: String?) -> [CurrencyModel] in
            let allSorted = self.sort(self.sortAZ.value, all)
            if let text = text, !text.isEmpty {
                return allSorted.filter({ $0.name.lowercased().contains(text.lowercased()) || $0.nameFull.lowercased().contains(text.lowercased()) })
            } else {
                return allSorted
            }
        }.bind(to: currencies).disposed(by: disposeBag)
    }

    func sortCurrencies() {
        sortAZ
            .subscribe { event -> Void in
                switch event {
                case let .next(next):
                    let currencies = self.sort(next, self.currencies.value)
                    self.currencies.accept(currencies)
                case let .error(error):
                    print(error)
                case .completed: break
                }
            }.disposed(by: disposeBag)
    }

    func tapSortButton() {
        sortAZ.accept(!sortAZ.value)
    }

    func sort(_ az: Bool, _ currencies: [CurrencyModel]) -> [CurrencyModel] {
        return currencies.sorted { az ? ($0.name < $1.name) : ($0.name > $1.name) }
    }

    //Retorna false se o "De" e "Para" já estivem setado para exibir uma mensagem de alerta na view.
    func tapCurrency(_ currency: CurrencyModel) -> Bool! {
        let from = fromText.value
        let to = toText.value
        let set = from.isEmpty || to.isEmpty

        if from.isEmpty {
            fromText.accept(currency.name)
            fromCurrency.accept(currency)
        } else if to.isEmpty {
            toText.accept(currency.name)
            toCurrency.accept(currency)
        }

        if !fromText.value.isEmpty {
            cleanEnabled.accept(true)

            if !toText.value.isEmpty {
                converterEnabled.accept(true)
            }
        }

        return set
    }

    func tapClean() {
        fromText.accept("")
        toText.accept("")
        fromCurrency.accept(CurrencyModel())
        toCurrency.accept(CurrencyModel())
        converterEnabled.accept(false)
        cleanEnabled.accept(false)
    }

    func sameCurrency(toCurrency: CurrencyModel) -> Bool {
        return fromText.value == toCurrency.name
    }
    
    func tapTryAgain() {
        fetchCurrencies()
    }
}
