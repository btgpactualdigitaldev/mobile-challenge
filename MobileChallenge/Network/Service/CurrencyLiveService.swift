//
//  CurrencyLiveService.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 13/10/20.
//

import Foundation

protocol ServiceLoadedDelegate: class {
    func didLoad(currencyLive: CurrencyLive)
    func error(message: String)
}

class CurrencyLiveService {
        
    weak var delegate: ServiceLoadedDelegate?
    
    init(delegate: ServiceLoadedDelegate?) {
        self.delegate = delegate
    }
    
    func request() {
        APIInstance.get().request(LiveRequest()) { (result) in
            switch result {
            case .success(let response):
                let object = response as! CurrencyLive
                self.delegate?.didLoad(currencyLive: object)
            case .failure(let error):
                self.delegate?.error(message: error)
            }
        }
    }
}
