//
//  CurrencyCellViewTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxSwift
import RxTest
import iOSSnapshotTestCase
@testable import BTGChallenge

class CurrencyCellViewTestCase: FBSnapshotTestCase {
    
    var sut: CurrencyCellView!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyCellView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
//        recordMode = true
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSnapshot() {
        FBSnapshotVerifyView(sut)
        FBSnapshotVerifyLayer(sut.layer)
    }

}
