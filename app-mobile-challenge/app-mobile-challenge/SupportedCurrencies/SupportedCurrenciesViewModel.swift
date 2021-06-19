//
//  SupportedCurrenciesViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

struct SupportedCurrenciesViewModel {

    // Properties

    var title: String { return Constants.title }

    // Private Methods

    private let coordinatorDelegate: CurrencyCoordinatorDelegate
    
    // Lifecycle

    init(coordinator: CurrencyCoordinatorDelegate) {
        self.coordinatorDelegate = coordinator
    }

    // Methods

    func backTapped() {
        ImpactFeedback.run(style: .heavy)
        coordinatorDelegate.backTapped()
    }

    func choiced(currency: List, type: PickCurrencyType) {
        if type == .none { return }
        ImpactFeedback.run(style: .heavy)
        switch type {
        case .none:
            return
        case .from:
            CommonData.shared.fromCurrencyStorage = currency.code
        case .to:
            CommonData.shared.toCurrencyStorage = currency.code
        }
        backTapped()
    }
}

// Constants

fileprivate extension SupportedCurrenciesViewModel {
    enum Constants {
        static let title: String = "Moedas"
    }
}
