//
//  RetrieveRemoteCurrenciesUseCase.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 07/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

class RetrieveRemoteCurrenciesUseCase {
    let service = CurrencyService()
    func execute(completion: @escaping ((CurrencyList?) -> Void)) {
        self.service.retrieveRemoteCurrencies { (currencies) in
            self.service.retrieveRemoteQuotes { (quotes) in
                guard let source = quotes?.source, let currencies: [Currency] = quotes?.quotes.compactMap({ quote in
                    let symbol = (quote.key == source+source) ? source : quote.key.replacingOccurrences(of: source, with: "")
                    return Currency(name: currencies?.currencies[symbol] ?? "", symbol: symbol, value: quote.value)
                }) else { completion(nil); return }
                completion(CurrencyList(currencies: currencies, source: source))
            }
        }
    }
}
