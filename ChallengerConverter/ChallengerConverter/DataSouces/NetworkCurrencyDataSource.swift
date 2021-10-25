//
//  NetworkCurrencyRepository.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation


class NetworkCurrencyDataSource: CurrencyDatSourceProtocol {
    func quotes(success: @escaping (([Quotes]) -> Void), fail: @escaping ((String) -> Void)) {
        BTGCurrencyService.request(provider: ApiProvider.live) { (completion: Result<LiveResult, Error>) in
            
            switch(completion) {
            case .success(let response):
                
                var quotes: [Quotes] = []
                
                response.quotes.forEach { currency in
                    quotes.append(Quotes(code: currency.key, quote: currency.value))
                }
                
                success(quotes)
            
                
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
    

    func currenciesAvaliable(success: @escaping (([Currency]) -> Void), fail: @escaping ((String) -> Void)) {

        BTGCurrencyService.request(provider: ApiProvider.list) { (completion: Result<CurrencyResposnse, Error>) in
            
            switch(completion) {
            case .success(let response):
                
                var currenciesAvaliable: [Currency] = []
                
                response.currencies.forEach { currency in
                    currenciesAvaliable.append(Currency(code: currency.key, name: currency.value))
                }
                
                success(currenciesAvaliable)
            
            case .failure(let error):
                fail(error.localizedDescription)
            }
        }
    }
}
