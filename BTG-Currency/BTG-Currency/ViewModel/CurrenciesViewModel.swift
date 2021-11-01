//
//  CurrenciesViewModel.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

public class CurrenciesViewModel {
    private(set) var items: [ListItem] = []
    private(set) var filteredItems: [ListItem] = []
    
    private let service: CurrenciesService
    
    private var cancellables: Set<AnyCancellable>
    private var filterPublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    
    private var listSubject = PassthroughSubject<Result<[ListItem], ServiceError>, Never>()
    public var listPublisher: AnyPublisher<Result<[ListItem], ServiceError>, Never> {
        listSubject.eraseToAnyPublisher()
    }
    
    private var connectivitySubject = PassthroughSubject<Bool, Never>()
    var connectivityPublisher: AnyPublisher<Bool, Never> {
        ConnectivityMonitor.shared.publisher
    }
    
    public init(service: CurrenciesService) {
        self.service = service
        self.cancellables = Set<AnyCancellable>()
    }
    
    public func fetchList() {
        service.fetchList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.listSubject.send(.failure(error))
                }
            } receiveValue: { [weak self] list in
                self?.items = list
                self?.filteredItems = list
                self?.sortByName()
            }.store(in: &cancellables)
    }
    
    public func sortByName() {
        filteredItems = NameSort.apply(collection: filteredItems)
        listSubject.send(.success(filteredItems))
    }
    
    public func sortByCode() {
        filteredItems = CodeSort.apply(collection: filteredItems)
        listSubject.send(.success(filteredItems))
    }
}

//MARK: - Binding
extension CurrenciesViewModel {
    public func attachFilterListener(_ publisher: AnyPublisher<String, Never>) {
        self.filterPublisher = publisher
        self.filterPublisher
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.filteredItems.removeAll()
            })
            .sink { [weak self] arg in
                let items = self?.items ?? []
                if arg.isEmpty {
                    self?.filteredItems = items
                } else {
                    self?.filteredItems = Filter.apply(items, arg: arg)
                }
                self?.listSubject.send(.success(self?.filteredItems ?? []))
            }.store(in: &cancellables)
    }
}
