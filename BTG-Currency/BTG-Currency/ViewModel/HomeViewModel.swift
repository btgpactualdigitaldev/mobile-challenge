//
//  HomeViewModel.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

public class HomeViewModel {
    //MARK: - Published attributes
    private(set) var inputCode: String = ""
    private(set) var inputValue: Decimal = 0.0
    private(set) var outputCode: String = ""
    private(set) var outputValue: Decimal = 0.0
    
    //MARK: - Service attribute
    private let service: HomeService
    
    //MARK: - Combine attributes
    private var cancellables: Set<AnyCancellable>
    
    private var inputValuePublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    private var inputCodePublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    private var outputCodePublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    
    private var convertSubject = PassthroughSubject<Result<String, ServiceError>, Never>()
    var convertPublisher: AnyPublisher<Result<String, ServiceError>, Never> {
        convertSubject.eraseToAnyPublisher()
    }
    
    private var connectivitySubject = PassthroughSubject<Bool, Never>()
    var connectivityPublisher: AnyPublisher<Bool, Never> {
        ConnectivityMonitor.shared.publisher
    }
    
    
    //MARK: - Initializer
    public init(service: HomeService) {
        self.service = service
        self.cancellables = Set<AnyCancellable>()
    }
}

//MARK: - Binding
extension HomeViewModel {
    public func attachInputValueListener(_ publisher: AnyPublisher<String, Never>) {
        self.inputValuePublisher = publisher
        self.inputValuePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.inputValue = value.toDecimal()
            }.store(in: &cancellables)
    }
    
    public func attachInputCodeListener(_ publisher: AnyPublisher<String, Never>) {
        self.inputCodePublisher = publisher
        self.inputCodePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] code in
                self?.inputCode = code
            }.store(in: &cancellables)
    }
    
    public func attachOutputCodeListener(_ publisher: AnyPublisher<String, Never>) {
        self.outputCodePublisher = publisher
        self.outputCodePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] code in
                self?.outputCode = code
            }.store(in: &cancellables)
    }
}

//MARK: - Service calls
extension HomeViewModel {
    public func convert() {
        guard inputCode != outputCode else {
            self.outputValue = inputValue
            self.convertSubject.send(.success(outputValue.toCurrency(withCode: outputCode)))
            return
        }
        
        let input = Currency(value: inputValue, code: inputCode)
        service.fetchLive(fromCurrency: input, toCurrencyCode: outputCode)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.convertSubject.send(.failure(error))
                }
            } receiveValue: { [weak self] value in
                self?.outputValue = value
                if let code = self?.outputCode {
                    let string = value.toCurrency(withCode: code)
                    self?.convertSubject.send(.success(string))
                }
            }.store(in: &cancellables)
    }
}

