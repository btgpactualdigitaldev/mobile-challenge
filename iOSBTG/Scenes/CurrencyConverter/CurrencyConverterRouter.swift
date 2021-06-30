//
//  CurrencyConverterRouter.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

@objc protocol CurrencyConverterRoutingLogic {
}


final class CurrencyConverterRouter: NSObject, CurrencyConverterRoutingLogic {
    
    weak var viewController: CurrencyConverterViewController?
    
}
