//
//  CoinListModel.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class CoinListModel: UIControl {
    var data: Currencies = Storage.retrieve(Constants.coinFile, from: .caches, as: GetCoinsResponse.self)?.currencies
        ?? [:]
    var items: [Coin] = []
    var ord = 0 { didSet { ordenateItems() } } // 0 = name, 1 = id
    var search: String = "" { didSet { startTimer() } }
    var timer: Timer?
    
    var reloadData: () -> Void = {}
    
    func fetchData() { Repository.getCoins(completion: fetchDataCompletion) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateItems()
        ordenateItems()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        generateItems()
        ordenateItems()
    }
}

private extension CoinListModel {
    func fetchDataCompletion(_ response: GetCoinsResponse?, _ error: Error?) {
        if (response?.success ?? false || DEBUG) {
            if let data = response {
                self.data = data.currencies ?? self.data
                Storage.store(data, to: .caches, as: Constants.coinFile)
                generateItems()
                ordenateItems()
            } else {
                Toast.show(message: L10n.System.Error.storage)
            }
        } else {
            Toast.show(message: L10n.System.Error.connection)
        }
        
        reloadData()
    }
    
    func filter(by text: String?) {
        var coins: [Coin] = []
        let t = Sanityze.normalize(text)
        
        if !t.isEmpty {
            for coin in data {
                let key = Sanityze.normalize(coin.key)
                let value = Sanityze.normalize(coin.value)
                if (key.contains(t)) || value.contains(t) { coins.append(Coin(coin)) }
            }
            
            items = coins
        } else {
            generateItems()
        }
        
        ordenateItems()
        
        reloadData()
    }
    
    func generateItems() {
        var n: [Coin] = []
        
        for d in data {
            n.append(Coin(d))
        }
        
        items = n
    }
    
    func ordenateItems() {
        switch ord {
        case 0:
            items.sort(by: { $0.name ?? "" < $1.name ?? "" })
        case 1:
            items.sort(by: { $0.code ?? "" < $1.code ?? "" })
        default:
            break
        }
    }
    
    func startTimer() {
        endTimer()
        timer = Timer.scheduledTimer(timeInterval: Constants.searchDelay,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    func endTimer() {
        timer?.invalidate()
    }
    
    @objc
    func timerAction() {
        filter(by: search)
    }
}
