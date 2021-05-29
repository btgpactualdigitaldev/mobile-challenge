//
//  QuotaViewModel.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 09/12/20.
//

import Foundation


class QuotaViewModel {
    
    private var manager: QuotaAPI
    
    var didFinishFetchCoins: (() -> ())?
    var didFinishFetchQuota: (() -> ())?
    var didFinishConvertToDolar: (() -> ())?

    private var coin: [String : String]? {
        didSet {
            guard let coin = coin else {
                return
            }
            let newCoins = coin.sorted { $0.key < $1.key }
            for (key,value) in newCoins {
                siglaCoins?.append(key)
                nameCoins?.append(value)
            }
            didFinishFetchCoins?()
        }
    }
    
    var siglaCoins: [String]? = []
    var nameCoins: [String]? = []
    
    var quota: [String : Float]? {
        didSet {
            quotaDestiny = quota?.first?.value
            didFinishFetchQuota?()
        }
    }
    
    var dolarValue: Float?
    var quotaDestiny: Float?
    var newValue: Float? {
        quotaDestiny! * dolarValue!
    }
    
    init(dataServiceAPI: QuotaAPI) {
        self.manager = dataServiceAPI
    }
    
    func fetchCoins() {
        let api = APIResource(endpoint: .list, httpMethod: .get, parameters: [:])

        manager.request(with: api) { (coin: Coins?) in
            guard let coin = coin else {return}
            self.coin = coin.coins
        }
    }
    
    func fetchQuota(with currencies: String) {
        let api = APIResource(endpoint: .live, httpMethod: .get, parameters: [.currencies: currencies])

        manager.request(with: api) { (quota: Quota?) in
            guard let quota = quota else {return}
            self.quota = quota.quotes
        }
    }
    
    func convertToDolar(with currencies: String, value: Float) {
        let api = APIResource(endpoint: .live, httpMethod: .get, parameters: [.currencies: currencies])

        manager.request(with: api) { (quota: Quota?) in
            guard let quota = quota else {return}
            self.dolarValue = value / quota.quotes.first!.value
            self.didFinishConvertToDolar?()
        }
    }

}
