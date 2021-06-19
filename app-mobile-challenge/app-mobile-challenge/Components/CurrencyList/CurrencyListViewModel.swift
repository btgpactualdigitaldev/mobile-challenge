//
//  CurrencyListViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class CurrencyListViewModel {

    // Private Properties

    private var currencies: Lists
    private var textSearched: String = ""
    private var filtedCurrencies: Lists { currenciesFilted }

    private var currenciesFilted: Lists {
        if textSearched.isEmpty { return currencies }
        return currencies.filter {
            let code = $0.name.range(of: textSearched, options: .caseInsensitive) != nil
            let name = $0.code.range(of: textSearched, options: .caseInsensitive) != nil

            return code || name
        }
    }

    private var favoriteCurrencies: Lists {
        filtedCurrencies.filter({$0.favorite})
    }

    // Lifecycle

    private var allCurrencies: Lists {
        filtedCurrencies.filter({!$0.favorite})
    }
    
    init(lists: Lists) {
        self.currencies = lists
    }

    // Methods

    func elementsBy(section: Int) -> Lists {
        return section == 0 ? favoriteCurrencies : allCurrencies
    }

    func elementBy(indexPath: IndexPath) -> List {
        let section = indexPath.section
        let row = indexPath.row
        return section == 0 ? favoriteCurrencies[row] : allCurrencies[row]
    }

    func title(section: Int) -> String {
        switch section {
        case .zero:
            return favoriteCurrencies.count > 0 ? "Favoritas" : ""
        default:
            return allCurrencies.count > 0 ? "Todas as moedas" : ""
        }
    }

    func toggleFavorite(indexPath: IndexPath) {
        var name = ""
        if indexPath.section == 0 {
            name = favoriteCurrencies[indexPath.row].name
        } else {
            name = allCurrencies[indexPath.row].name
        }
        guard let index = currencies.firstIndex(where: {$0.name==name}) else { return }
        currencies[index].favorite.toggle()
        currencies[index].saveFavorite()
        ImpactFeedback.run(style: .light)
    }

    func filterBy(textSearched: String) {
        self.textSearched = textSearched
    }

    func inicializeFavorites() {
        let favorites = CommonData.shared.favorites
        for favorite in favorites {
            if let index = currencies.firstIndex(where: { $0.code == favorite }) {
                currencies[index].favorite.toggle()
            }
        }
    }
}
