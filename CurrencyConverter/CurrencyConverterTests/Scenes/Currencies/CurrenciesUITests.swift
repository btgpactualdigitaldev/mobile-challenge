//
//  CurrenciesUITests.swift
//  CurrencyConverterTests
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 17/07/22.
//

import Foundation
@testable import CurrencyConverter
import XCTest
import SnapshotTesting

final class CurrenciesUITests: XCTestCase {

    func testCurrenciesListSuccess() {
        // given
        let serviceMock = CurrenciesServiceMock()
        let viewModel = CurrenciesViewModel(service: serviceMock)
        let mockedCurrenciesList = Currencies(currencies: ["AED": "United Arab Emirates Dirham"])

        let sut = CurrenciesViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: sut)
        
        // when
        serviceMock.result = .success(mockedCurrenciesList)
        sut.loadView()

        // then
        assertSnapshot(matching: navController, as: .image(size: .init(width: 390, height: 844)))

    }

    func testCurrenciesListdidFailToFetch() {
        let serviceMock = CurrenciesServiceMock()
        let viewModel = CurrenciesViewModel(service: serviceMock)

        let sut = CurrenciesViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: sut)
        // when
        serviceMock.result = .failure(.parseError)
        sut.loadView()

        // then
        assertSnapshot(matching: navController, as: .image(size: .init(width: 390, height: 844)))
    }

}
