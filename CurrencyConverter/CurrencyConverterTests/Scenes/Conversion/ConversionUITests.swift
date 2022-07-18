//
//  UI.swift
//  CurrencyConverterTests
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 17/07/22.
//

import Foundation
@testable import CurrencyConverter
import XCTest
import SnapshotTesting

final class ConversionUITests: XCTestCase {
    
    func testConversionInputNotEnabled() {
        // given
        let serviceMock = ConversionServiceMock()
        let viewModel = ConversionViewModel(service: serviceMock)
        let sut = ConversionViewController(viewModel: viewModel)
        
        // then
        assertSnapshot(matching: sut, as: .image(size: .init(width: 390, height: 844)))
    }
    
    func testConversionInputEnabled() {
        // given
        let serviceMock = ConversionServiceMock()
        let viewModel = ConversionViewModel(service: serviceMock)
        let mockedInitialCurrency = "USDAED"
        let mockedFinalCurrency = "USDAFN"
        let sut = ConversionViewController(viewModel: viewModel)
        
        // when
        
        sut.didSelectCurrency(currency: mockedInitialCurrency, isInitial: true)
        sut.didSelectCurrency(currency: mockedFinalCurrency, isInitial: false)
        
        // then
        assertSnapshot(matching: sut, as: .image(size: .init(width: 390, height: 844)))
        
    }
    
}
