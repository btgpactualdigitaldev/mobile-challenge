//
//  ConversionRouter.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ConversionRouterDelegate
protocol ConversionRouterDelegate: class {
    func currencyFetched(_ code: String, _ name: String, _ conversion: Conversion)
}

// MARK: - Main
class ConversionRouter {
    
    private let window: UIWindow
    weak var delegate: ConversionRouterDelegate?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func createConversionScreen() {
        let viewController = ConversionViewController(
            viewModel: ConversionViewModel(
                service: CurrenciesConversionService(),
                dataManager: DataManager(),
                router: self
        ))
        
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func enqueueListCurrencies(_ conversion: Conversion) {
        let router = ListCurrenciesRouter()
        router.delegate = self
        
        router.createListCurrenciesScreen(
            conversion: conversion
        )
    }
}

// MARK: - ListCurrenciesRouterDelegate
extension ConversionRouter: ListCurrenciesRouterDelegate {
    func currencyFetched(_ code: String, _ name: String, _ conversion: Conversion) {
        delegate?.currencyFetched(code, name, conversion)
    }
}
