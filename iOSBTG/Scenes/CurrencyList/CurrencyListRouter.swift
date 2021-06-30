//
//  CurrencyListRouter.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

@objc protocol CurrencyListRoutingLogic {
}

final class CurrencyListRouter: NSObject, CurrencyListRoutingLogic {
    
    weak var viewController: CurrencyListViewController?
    
}
