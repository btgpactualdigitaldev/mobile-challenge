//
//  ConversionViewTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxSwift
import RxTest
import iOSSnapshotTestCase
@testable import BTGChallenge

class ConversionViewTestCase: FBSnapshotTestCase {
    
    var sut: ConversionView!
    var delegate: ConversionDelegateSpy!
    var viewModel: ConversionViewModel!
    var userDefaultFake: UserDefaultFake!
    var service: ConversionServiceStub!
    
    override func setUp() {
        super.setUp()
        service = ConversionServiceStub()
        delegate = ConversionDelegateSpy()
        userDefaultFake = UserDefaultFake()
        viewModel = ConversionViewModel(acronym: String(), service: service, userDefault: userDefaultFake)
        sut = ConversionView(viewModel: viewModel, frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        sut.delegate = delegate
//        recordMode = true
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        delegate = nil
        viewModel = nil
        userDefaultFake = nil
        super.tearDown()
    }

    func testSnapshot() {
        FBSnapshotVerifyView(sut)
        FBSnapshotVerifyLayer(sut.layer)
    }

    func testConvertClicked() {
        sut.inputValueConvertion.text = "3.00"
        sut.pressedConvert()
        XCTAssertEqual(delegate.buttonConvertClickedValue, "3.00")
    }
    
    func testChoiceOneClicked() {
        sut.pressedChoiceOne()
        XCTAssertTrue(delegate.buttonChoiceCurrencyOneCalled)
    }
    
    func testChoiceTwoClicked() {
        sut.pressedChoiceTwo()
        XCTAssertTrue(delegate.buttonChoiceCurrencyTwoCalled)
    }
    
}
