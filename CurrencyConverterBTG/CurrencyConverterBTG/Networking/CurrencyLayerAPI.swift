//
//  CurrencyLayerAPI.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import Foundation

final class CurrencyLayerAPI {
    private static let base = "http://api.currencylayer.com/"
    private static let accessKey = "5fce2e7a8a6676ece9540533be7e3daf"
    private static let supportedCurrenciesURL = base + "list?access_key=" + accessKey
    private static let realTimeRatesURL = base + "live?access_key=" + accessKey

    static let shared = CurrencyLayerAPI()
    private init() { }

    func fetchSupportedCurrencies(completion: @escaping (Result<CurrenciesDTO, NetworkingError>) -> Void) {
        Networking.request(url: CurrencyLayerAPI.supportedCurrenciesURL, completion: completion)
    }
    
    func fetchConversions(completion: @escaping (Result<ConversionsDTO, NetworkingError>) -> Void) {
        Networking.request(url: CurrencyLayerAPI.realTimeRatesURL, completion: completion)
    }
}
