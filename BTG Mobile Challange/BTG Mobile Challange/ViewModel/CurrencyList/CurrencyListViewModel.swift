//
//  CurrencyListViewModel.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

public class CurrencyListViewModel {

    // MARK: - Bindable variables

    @Published var currencyList: [Dictionary<String, String>.Element]?

    // MARK: - Variables

    private var originalCurrencyList: [Dictionary<String, String>.Element]? {
        didSet {
            currencyList = originalCurrencyList
        }
    }

    // MARK: - Constants

    private let servicesProvider: CurrencyListServiceProtocol

    // MARK: - Lyfecycle and constructors

    init(servicesProvider: CurrencyListServiceProtocol) {
        self.servicesProvider = servicesProvider
        servicesProvider.fetchCurrencyList { response in
            switch response {
            case .failure:
                self.currencyList = nil
            case .success(let data):
                self.originalCurrencyList = data.currencies?.sorted { $0.key < $1.key }
            }
        }
    }

    // MARK: - Public functions

    func filter(by text: String) {
        if text.isEmpty {
            currencyList = originalCurrencyList
        } else {
            currencyList = originalCurrencyList?.filter { $0.key.lowercased().contains(text.lowercased()) || $0.value.lowercased().contains(text.lowercased()) }
        }
    }

    func sort(sortType: CurrencyListSort) {
        switch sortType {
        case .currencyCodeAscending:
            self.originalCurrencyList?.sort {$0.key < $1.key}
        case .currencyCodeDescending:
            self.originalCurrencyList?.sort {$0.key > $1.key}
        case .nameAscending:
            self.originalCurrencyList?.sort {$0.value < $1.value}
        case .nameDescending:
            self.originalCurrencyList?.sort {$0.value > $1.value}
        default:
            return
        }
    }
}
