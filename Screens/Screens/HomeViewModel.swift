//
//  HomeViewModel.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Storage
import Networking
import Models
import Service

class HomeViewModel {
    
    private(set) lazy var currencyPairSubscriber = CurrencyPairSubscriber(viewModel: self)
    private(set) lazy var quotesPublisher = QuotesSubscriber(viewModel: self)
    @Configured(valueKey: "com.almeidaws.Currency.quota", defaultValue: CurrencyPair(first: "USD", second: "BRL"))
    private(set) var quote: CurrencyPair
    var selectedCurrencyPair: CurrencyPairElement?
    
    class QuotesSubscriber: Publisher {
        
        typealias Output = Model
        typealias Failure = HomeViewModelError
        
        private var cancellable: AnyCancellable?
        private weak var viewModel: HomeViewModel?
        private let publisher = PassthroughSubject<Model, HomeViewModelError>()
        private let storage: Storage = Services.make(for: Storage.self)
        private let requester: Requester = Services.make(for: Requester.self)
        
        init(viewModel: HomeViewModel) {
            self.viewModel = viewModel
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, HomeViewModelError == S.Failure, Model == S.Input {
            publisher.receive(subscriber: subscriber)
            deliver(to: subscriber)
        }
        
        private func deliver<S>(to subscriber: S) where S : Subscriber, HomeViewModelError == S.Failure, Model == S.Input {
            guard let viewModel = self.viewModel else { return }
            cancellable = readQuotes()
                .merge(with: fetchQuotes())
                .filter { !$0.isEmpty }
                .map { quotes in
                    let first = viewModel.quote.first
                    let second = viewModel.quote.second
                    
                    if first == "USD" {
                        let `default` = quotes.first { quote in quote.model.first == first && quote.model.second == second }
                        return Model(default: `default`, quotes: quotes)
                    } else {
                        let mid = quotes.first { quote in quote.model.second == first }!
                        let target = quotes.first { quote in quote.model.second == second }!
                        let converted = 1 / mid.model.value * target.model.value
                        let quote = Quote(first, second, converted)
                        return Model(default: Row(model: quote, updatedAt: target.updatedAt), quotes: quotes)
                    }
                    
                }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.publisher.send(completion: .failure(error))
                        self.publisher.send(completion: .finished)
                    case .finished:
                        break
                    }
                },
                      receiveValue: { result in self.publisher.send(result) })
        }
        
        private func fetchQuotes() -> AnyPublisher<[Row<Quote>], HomeViewModelError> {
            return requester.realTimeRates()
                .mapError { error in HomeViewModelError.network(error) }
                .flatMap { quotes in self.storage.write(quotes).mapError { error in HomeViewModelError.storage(error)} }
                .flatMap { _ in self.storage.read().mapError { error in HomeViewModelError.storage(error)} }
                .eraseToAnyPublisher()
        }
        
        private func readQuotes() -> AnyPublisher<[Row<Quote>], HomeViewModelError> {
            let quotesPublisher: AnyPublisher<[Row<Quote>], StorageError> = storage.read()
            return quotesPublisher.mapError { error in HomeViewModelError.storage(error) }.eraseToAnyPublisher()
        }
        
        enum HomeViewModelError: Error {
            case storage(StorageError)
            case network(RequestError)
            
            var description: String {
                switch self {
                case .storage(let error): return "Storage: \(error)"
                case .network(let error): return "Network: \(error)"
                }
            }
        }
    }
    
    class CurrencyPairSubscriber: Subscriber {
        private var subscription: Subscription?
        private weak var viewModel: HomeViewModel?
        
        init(viewModel: HomeViewModel) {
            self.viewModel = viewModel
        }
        
        func receive(subscription: Subscription) {
            subscription.request(.unlimited)
            self.subscription = subscription
        }
        
        func receive(_ currency: Currency) -> Subscribers.Demand {
            guard let viewModel = self.viewModel else { return .none }
            guard let selectedCurrencyPair = viewModel.selectedCurrencyPair else { return .none }
            switch selectedCurrencyPair {
            case .first:
                viewModel.quote = CurrencyPair(first: currency.abbreviation, second: viewModel.quote.second)
            case .second:
                viewModel.quote = CurrencyPair(first: viewModel.quote.first, second: currency.abbreviation)
            }
            return .none
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            subscription?.cancel()
            subscription = nil
        }
    }
    
    struct Model {
        let `default`: Row<Quote>!
        let quotes: [Row<Quote>]
    }
    
    struct CurrencyPair: Codable {
        let first: String
        let second: String
    }
}

enum CurrencyPairElement {
    case first(String)
    case second(String)
}
