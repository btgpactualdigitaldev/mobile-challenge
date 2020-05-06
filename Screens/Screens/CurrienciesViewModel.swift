//
//  CurrienciesViewModel.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Models
import Storage
import Networking
import Service

class CurrenciesViewModel {
    
    private(set) lazy var currencyPublisher = CurrencyPublisher(viewModel: self)
    private(set) lazy var currenciesPublisher = CurrenciesPublisher(viewModel: self)
    
    class CurrencyPublisher: Publisher {
        typealias Output = Currency
        typealias Failure = Never
        
        private let publisher = PassthroughSubject<Currency, Never>()
        private var cancellable: AnyCancellable?
        private weak var viewModel: CurrenciesViewModel?
        
        init(viewModel: CurrenciesViewModel) {
            self.viewModel = viewModel
        }
        
        func send(_ currency: Currency) {
            publisher.send(currency)
            publisher.send(completion: .finished)
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Currency == S.Input {
            publisher.receive(subscriber: subscriber)
        }
    }
    
    class CurrenciesPublisher: Publisher {
        
        typealias Output = [Currency]
        typealias Failure = CurrenciesViewModelError
        private let storage: Storage = Services.make(for: Storage.self)
        private let requester: Requester = Services.make(for: Requester.self)
        private let publisher = PassthroughSubject<[Currency], CurrenciesViewModelError>()
        private var cancellable: AnyCancellable?
        private weak var viewModel: CurrenciesViewModel?
        
        init(viewModel: CurrenciesViewModel) {
            self.viewModel = viewModel
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, CurrenciesViewModelError == S.Failure, [Currency] == S.Input {
            publisher.receive(subscriber: subscriber)
            deliver(to: subscriber)
        }
        
        private func deliver<S>(to subscriber: S) where S : Subscriber, CurrenciesViewModelError == S.Failure, [Currency] == S.Input {
            
            let networkPublisher = requester.supportedCurrencies()
                .mapError { CurrenciesViewModelError.network($0) }
                .eraseToAnyPublisher()
            
            let publisher: AnyPublisher<[Row<Currency>], StorageError> = storage.read()
            cancellable = publisher
                .mapError { CurrenciesViewModelError.storage($0) }
                .map { $0.map { $0.model }}
                .merge(with: networkPublisher)
                .flatMap { self.storage.write($0).mapError { CurrenciesViewModelError.storage($0) } }
                .sink(receiveCompletion: { completion in self.publisher.send(completion: completion) },
                      receiveValue: { currencies in _ = self.publisher.send(currencies) })
        }
    }
}

enum CurrenciesViewModelError: Error, CustomStringConvertible {
    case storage(StorageError)
    case network(RequestError)
    
    var description: String {
        switch self {
        case .storage(let error): return "Storage: \(error)"
        case .network(let error): return "Network: \(error)"
        }
    }
}
