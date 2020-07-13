//
//  ConverterCurrencyBTGTests.swift
//  ConverterCurrencyBTGTests
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import XCTest
@testable import ConverterCurrencyBTG
import Foundation

class ConverterCurrencyBTGTests: XCTestCase {
    var interactor: HomeInteractor!
    var presenter: HomePresenter!
    var view: HomeController!
    override func tearDown() {
        super.tearDown()
        presenter = nil
        interactor = nil
        view = nil
        
    }
    override func setUp() {
        super.setUp()
        let localDataInteractor = LocalDataInteractorMock()
        interactor = HomeInteractor(manager: CurrencyManager(client: CurrencyManagerMock()), localDataInteractor: localDataInteractor)
        presenter = HomePresenter(route: HomeWireframe(), interactor: interactor)
        interactor.output = presenter
        view = HomeController()
        view.presenter = presenter
        presenter.output = view
        
    }
    
    func testViewModel(){
        interactor.loadRequest()
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            exp.fulfill()
            XCTAssertEqual(presenter.viewModelTo.currency, "BRL")
            XCTAssertEqual(presenter.viewModelTo.name, "Brazilian Real")
            XCTAssertEqual(presenter.viewModelFrom.currency, "USD")
            XCTAssertEqual(presenter.viewModelFrom.name, "United States Dollar")
            
        }
    }
    
    func testConvert(){
        if let listLive: ListQuotes = Loader.mock(file: "live"), let listModel: ListCurrenciesModel = Loader.mock(file: "list") {
            let entites = CurrencyEntityMapper.mappingListCurrency(listCurrency: listModel, listQuotes: listLive)
            interactor.entites = entites
            XCTAssert(!interactor.entites.isEmpty)
            presenter.fetched(entites: interactor.entites)
            
            presenter.send(amount: 20)
            if let textResult = view.resultLabel.text {
                XCTAssertEqual(textResult, "Valor Convertido é: 3,76")

            }
        }
    }
}

class LocalDataInteractorMock: LocalDataInteractorInput {
    
    func load() -> [CurrencyEntity] {
        return []
    }
    
    func save(entites: [CurrencyEntity]) {
        
    }
    
    
}
