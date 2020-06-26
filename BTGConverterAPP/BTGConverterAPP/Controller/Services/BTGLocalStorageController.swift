//
//  LocalStorageController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 17/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol LocalStorage {
    func getLiveQuoteRates() -> LiveQuoteRates?
    func setLiveQuoteRates(_ liveQuoteRates: LiveQuoteRates)
    func getAvaliableQuotes() -> [CurrencyDescription]?
    func setAvaliableQuotes(_ avaliableDescriptions: [CurrencyDescription])
    
    func isLocalStorageValid(ofType type: LocalStorageDataType) -> Bool
    func getTimeToLive(ofType type: LocalStorageDataType) -> Date?
}

enum LocalStorageDataType {
    case liveQuoteRates
    case avaliableQuotes
}

struct BTGLocalStorage : LocalStorage {
    private let secondsToLive : Double = 10
    let typeDict = [LocalStorageDataType.liveQuoteRates: LocalCacheKeys.timeToLiveLiveQuoteDate,
                    LocalStorageDataType.avaliableQuotes: LocalCacheKeys.avaliableCurrencies]
    
    func isLocalStorageValid(ofType type: LocalStorageDataType) -> Bool {
        guard let localStorageType = typeDict[type],
            let dateFromCache = getFromLocalStorage(ofType: localStorageType) as Date? else { return false }
         return dateFromCache.distance(to: Date()) < secondsToLive
    }
    
    func getLiveQuoteRates() -> LiveQuoteRates? {
        return getFromLocalStorage(ofType: .liveQuoteRates)
    }
    
    func setLiveQuoteRates(_ liveQuoteRates: LiveQuoteRates) {
        saveToLocalStorage(data: liveQuoteRates, ofType: .liveQuoteRates)
        saveToLocalStorage(data: Date(), ofType: .timeToLiveLiveQuoteDate)
    }
    
    func getAvaliableQuotes() -> [CurrencyDescription]? {
        return getFromLocalStorage(ofType: .avaliableCurrencies)
    }
    
    func setAvaliableQuotes(_ avaliableDescriptions: [CurrencyDescription]) {
        saveToLocalStorage(data: avaliableDescriptions, ofType: .avaliableCurrencies)
        saveToLocalStorage(data: Date(), ofType: .timeToLiveAvaliableQuoteDate)
    }
    
    func getTimeToLive(ofType type: LocalStorageDataType) -> Date? {
        switch type {
        case .liveQuoteRates:
            return getFromLocalStorage(ofType: .timeToLiveLiveQuoteDate)
        case .avaliableQuotes:
            return getFromLocalStorage(ofType: .timeToLiveAvaliableQuoteDate)
        }
    }

    
    private func saveToLocalStorage<T:Encodable>(data: T,ofType localCacheKeys: LocalCacheKeys ) {
        let jsonEncoder = JSONEncoder()
        guard let savedData = try? jsonEncoder.encode(data) else { return }
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: localCacheKeys.rawValue)
    }
    
    private func getFromLocalStorage<T:Decodable>(ofType localCacheKeys: LocalCacheKeys) -> T? {
        var data: T? = nil
        
        let defaults = UserDefaults.standard
        guard let savedData = defaults.object(forKey: localCacheKeys.rawValue) as? Data else { return data }
        let jsonDecoder = JSONDecoder()
        do {
            data = try jsonDecoder.decode(T.self, from: savedData)
        } catch {
            return nil
        }
        return data
    }
}
