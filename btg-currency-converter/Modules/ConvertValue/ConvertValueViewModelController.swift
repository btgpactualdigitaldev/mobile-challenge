//
//  ConvertValueViewModelController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 24/11/20.
//

import Foundation
import UIKit


class ConvertValueViewModelController {
    var coin: String?
    var rate: RateEntity = RateEntity()
    
    func retrieveRate(_ success: (() -> Void)?, failure: (() -> Void)?) {
        CoinService.shared.coin = coin
        
        CoinService.shared.getRate { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                if model.success ?? false {
                    self.rate = model
                    success?()
                } else {
                    failure?()
                }
            case .failure(_):
                failure?()
            }
        }

    }    
}
