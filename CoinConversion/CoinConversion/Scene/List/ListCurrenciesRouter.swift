//
//  ListCurrenciesRouter.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 21/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ConversionViewModelDelegate
protocol ListCurrenciesRouterDelegate: class {
    func currencyFetched(_ code: String, _ name: String, _ conversion: Conversion)
}

// MARK: - Main
class ListCurrenciesRouter {
    weak var delegate: ListCurrenciesRouterDelegate?
    
    func createListCurrenciesScreen(conversion: Conversion) {
        let viewController = ListCurrenciesViewController(
            viewModel: ListCurrenciesViewModel(
                service: ListCurrenciesService(),
                conversion: conversion,
                dataManager: DataManager(),
                router: self
        ))
        
        if let topViewController = UIApplication.shared.topMostViewController() {
            topViewController.navigationController?.pushViewController(
                viewController, animated: true
            )
        }
    }
    
    func dismissToConversion(_ code: String, _ name: String, _ conversion: Conversion) {
        delegate?.currencyFetched(
            code,
            name,
            conversion
        )
        DispatchQueue.main.async(execute: {
            if let topViewController = UIApplication.shared.topMostViewController() {
                topViewController.navigationController?.popViewController(animated: true)
            }
        })
    }
}
