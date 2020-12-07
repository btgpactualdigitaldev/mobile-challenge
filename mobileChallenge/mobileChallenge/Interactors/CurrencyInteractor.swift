//
//  CurrencyInteractor.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import Foundation
import Combine

struct CurrencyInteractor {
    let didFail: (_ error: ServiceError) -> Void
    let didReceiveCurrencies: (_ currencies: [String: Any]) -> Void
    
    func fetchLives() {
        var publishers = [AnyCancellable]()
        Api.shared.lives()
        .map { $0 }
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.didFail(.unexpected)
            case .finished:
                break
            }},
              receiveValue: {
                self.didReceiveCurrencies($0.quotes)
        })
        .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
        withExtendedLifetime(publishers, {})
    }
    
    func fetchList() {
        var publishers = [AnyCancellable]()
        Api.shared.lists()
        .map { $0 }
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.didFail(.unexpected)
            case .finished:
                break
            }},
              receiveValue: {
                self.didReceiveCurrencies($0.currencies)
        })
        .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
        withExtendedLifetime(publishers, {})
    }

}
    

