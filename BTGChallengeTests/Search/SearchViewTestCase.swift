//
//  SearchViewTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxBlocking
import RxSwift
import RxTest
import iOSSnapshotTestCase
@testable import BTGChallenge

class SearchViewTestCase: FBSnapshotTestCase {
    
    var sut: SearchView!
    var delegate: SearchDelegateSpy!
    var viewModel: SearchViewModel!
    var service: SearchServiceStub!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var result: TestableObserver<IndexPath>!
    
    
    override func setUp() {
        super.setUp()
        service = SearchServiceStub()
        delegate = SearchDelegateSpy()
        scheduler = TestScheduler(initialClock: 0)
        result = scheduler.createObserver(IndexPath.self)
        disposeBag = DisposeBag()
        viewModel = SearchViewModel(service: service)
        sut = SearchView(viewModel: viewModel, frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        sut.delegate = delegate
//        recordMode = true
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        delegate = nil
        viewModel = nil
        scheduler = nil
        disposeBag = nil
        result = nil
        super.tearDown()
    }

    func testSnapshot() {
        service.result = [
            "BRL": "Brazilian Real",
        ]
        sut.viewModel.fechCurrencys()
        FBSnapshotVerifyView(sut)
        FBSnapshotVerifyLayer(sut.layer)
    }
    
}
